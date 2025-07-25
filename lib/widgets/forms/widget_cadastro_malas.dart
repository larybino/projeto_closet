import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dao/MalaDAO.dart';
import 'package:projeto_lary/banco/dao/acessorioDAO.dart';
import 'package:projeto_lary/banco/dao/eventoDAO.dart';
import 'package:projeto_lary/banco/dao/roupaDAO.dart';
import 'package:projeto_lary/banco/dao/sapatoDAO.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOEvento.dart';
import 'package:projeto_lary/banco/dto/DTOMala.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import '../componentes/seletor_itens.dart';

class WidgetCadastroMala extends StatefulWidget {
  final DTOMala? mala;

  const WidgetCadastroMala({super.key, this.mala});

  @override
  State<WidgetCadastroMala> createState() => _WidgetCadastroMalaState();
}

class _WidgetCadastroMalaState extends State<WidgetCadastroMala> {
  final _formKey = GlobalKey<FormState>();
  final _malaDAO = MalaDAO();

  late final TextEditingController _nomeController;
  
  late Future<List<DTOEvento>> _eventosFuture;
  late Future<List<DTORoupas>> _roupasFuture;
  late Future<List<DTOSapato>> _sapatosFuture;
  late Future<List<DTOAcessorios>> _acessoriosFuture;

  DTOEvento? _eventoSelecionado;
  final List<DTORoupas> _roupasSelecionadas = [];
  final List<DTOSapato> _sapatosSelecionados = [];
  final List<DTOAcessorios> _acessoriosSelecionados = [];

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.mala?.nome);

    if (widget.mala != null) {
      _eventoSelecionado = widget.mala!.evento;
      _roupasSelecionadas.addAll(widget.mala!.roupas);
      _sapatosSelecionados.addAll(widget.mala!.sapatos);
      _acessoriosSelecionados.addAll(widget.mala!.acessorios);
    }
    
    _carregarDados();
  }

  void _carregarDados() {
    _eventosFuture = EventoDAO().listar();
    _roupasFuture = RoupaDAO().listar();
    _sapatosFuture = SapatoDAO().listar();
    _acessoriosFuture = AcessorioDAO().listar();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState?.validate() ?? false) {
      final malaParaSalvar = DTOMala(
        id: widget.mala?.id,
        nome: _nomeController.text,
        evento: _eventoSelecionado,
        roupas: _roupasSelecionadas,
        sapatos: _sapatosSelecionados,
        acessorios: _acessoriosSelecionados,
      );

      try {
        await _malaDAO.salvar(malaParaSalvar);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.mala == null ? 'Mala salva com sucesso!' : 'Mala atualizada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar mala: $e'),
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
        title: Text(widget.mala == null ? 'Nova Mala' : 'Editar Mala'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Container(
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
                      labelText: 'Nome da Mala (ex: Viagem de Fim de Semana)',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white70,
                    ),
                    validator: (value) => (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
                  ),
                  const SizedBox(height: 20),
                  _buildEventoSelector(),
                  const SizedBox(height: 24),
                  WidgetSeletorDeItens<DTORoupas>(
                    titulo: 'Roupas',
                    future: _roupasFuture,
                    itensSelecionados: _roupasSelecionadas,
                    nomeItem: (item) => item.modelo ?? 'Sem nome',
                    onSelecaoMudou: (novaLista) {
                      setState(() {
                        _roupasSelecionadas.clear();
                        _roupasSelecionadas.addAll(novaLista);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  WidgetSeletorDeItens<DTOSapato>(
                    titulo: 'Sapatos',
                    future: _sapatosFuture,
                    itensSelecionados: _sapatosSelecionados,
                    nomeItem: (item) => item.modelo ?? 'Sem nome',
                    onSelecaoMudou: (novaLista) {
                      setState(() {
                        _sapatosSelecionados.clear();
                        _sapatosSelecionados.addAll(novaLista);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  WidgetSeletorDeItens<DTOAcessorios>(
                    titulo: 'Acessórios',
                    future: _acessoriosFuture,
                    itensSelecionados: _acessoriosSelecionados,
                    nomeItem: (item) => item.modelo ?? 'Sem nome',
                    onSelecaoMudou: (novaLista) {
                      setState(() {
                        _acessoriosSelecionados.clear();
                        _acessoriosSelecionados.addAll(novaLista);
                      });
                    },
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
                      child: const Text('Salvar Mala', style: TextStyle(fontSize: 18, color: Colors.white)),
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

  Widget _buildEventoSelector() {
    return FutureBuilder<List<DTOEvento>>(
      future: _eventosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('Nenhum evento cadastrado para associar.');
        }

        final eventos = snapshot.data!;
        return DropdownButtonFormField<DTOEvento>(
          value: _eventoSelecionado,
          decoration: const InputDecoration(
            labelText: 'Associar a um Evento (Opcional)',
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white70,
          ),
          items: eventos.map((evento) {
            return DropdownMenuItem<DTOEvento>(
              value: evento,
              child: Text(evento.nome ?? 'Evento sem nome'),
            );
          }).toList(),
          onChanged: (DTOEvento? newValue) {
            setState(() {
              _eventoSelecionado = newValue;
            });
          },
        );
      },
    );
  }
}