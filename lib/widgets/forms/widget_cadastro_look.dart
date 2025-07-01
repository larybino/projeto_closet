import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dao/RoupaDAO.dart';
import 'package:projeto_lary/banco/dao/acessorioDAO.dart';
import 'package:projeto_lary/banco/dao/lookDAO.dart';
import 'package:projeto_lary/banco/dao/sapatoDAO.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';


class WidgetCadastroLook extends StatefulWidget {
  final DTOLook? look;

  const WidgetCadastroLook({super.key, this.look});

  @override
  State<WidgetCadastroLook> createState() => _WidgetCadastroLookState();
}

class _WidgetCadastroLookState extends State<WidgetCadastroLook> {
  final _formKey = GlobalKey<FormState>();
  final _lookDAO = LookDAO();

  late final TextEditingController _nomeController;
  
  late Future<List<DTORoupas>> _roupasFuture;
  late Future<List<DTOSapato>> _sapatosFuture;
  late Future<List<DTOAcessorios>> _acessoriosFuture;

  final List<DTORoupas> _roupasSelecionadas = [];
  final List<DTOSapato> _sapatosSelecionados = [];
  final List<DTOAcessorios> _acessoriosSelecionados = [];

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.look?.nome);

    if (widget.look != null) {
      _roupasSelecionadas.addAll(widget.look!.roupas);
      _sapatosSelecionados.addAll(widget.look!.sapatos);
      _acessoriosSelecionados.addAll(widget.look!.acessorios);
    }
    
    _carregarItens();
  }

  void _carregarItens() {
    _roupasFuture = RoupaDAO().listar();
    _sapatosFuture = SapatoDAO().listar();
    _acessoriosFuture = AcessorioDAO().listar();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState?.validate() ?? false) {
      final lookParaSalvar = DTOLook(
        id: widget.look?.id,
        nome: _nomeController.text,
        roupas: _roupasSelecionadas,
        sapatos: _sapatosSelecionados,
        acessorios: _acessoriosSelecionados,
      );

      try {
        await _lookDAO.salvar(lookParaSalvar);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.look == null ? 'Look salvo com sucesso!' : 'Look atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar look: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.look == null ? 'Novo Look' : 'Editar Look'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 240, 174, 226),
            ],
          ),
        ),
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Look',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 24),
                
                _buildItemSelector<DTORoupas>(
                  title: 'Roupas',
                  future: _roupasFuture,
                  selectedItems: _roupasSelecionadas,
                  itemBuilder: (roupa) => roupa.modelo ?? 'Sem nome',
                ),
                const SizedBox(height: 16),

                _buildItemSelector<DTOSapato>(
                  title: 'Sapatos',
                  future: _sapatosFuture,
                  selectedItems: _sapatosSelecionados,
                  itemBuilder: (sapato) => sapato.modelo ?? 'Sem nome',
                ),
                const SizedBox(height: 16),

                _buildItemSelector<DTOAcessorios>(
                  title: 'Acessórios',
                  future: _acessoriosFuture,
                  selectedItems: _acessoriosSelecionados,
                  itemBuilder: (acessorio) => acessorio.estilo ?? 'Sem nome',
                ),
                const SizedBox(height: 32),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('Salvar', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildItemSelector<T>({
    required String title,
    required Future<List<T>> future,
    required List<T> selectedItems,
    required String Function(T) itemBuilder,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const Divider(),
        FutureBuilder<List<T>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Text('Erro ao carregar itens: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('Nenhum item cadastrado.');
            }

            final allItems = snapshot.data!;
            return Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: allItems.map((item) {
                final isSelected = selectedItems.any((selected) => (selected as dynamic).id == (item as dynamic).id);
                return FilterChip(
                  label: Text(itemBuilder(item)),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        selectedItems.add(item);
                      } else {
                        selectedItems.removeWhere((selected) => (selected as dynamic).id == (item as dynamic).id);
                      }
                    });
                  },
                  selectedColor: const Color.fromARGB(255, 243, 33, 219).withOpacity(0.4),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
