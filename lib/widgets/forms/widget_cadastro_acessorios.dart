import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/repositories/acessorio_repository.dart';
import '../componentes/campo_texto.dart';

class WidgetCadastroAcessorios extends StatefulWidget {
  final DTOAcessorios? acessorio;

  const WidgetCadastroAcessorios({super.key, this.acessorio});

  @override
  State<WidgetCadastroAcessorios> createState() => _WidgetCadastroAcessoriosState();
}

class _WidgetCadastroAcessoriosState extends State<WidgetCadastroAcessorios> {
  final _formKey = GlobalKey<FormState>();
  final _acessorioRepository = AcessorioRepository();

  late final TextEditingController _modeloController;
  late final TextEditingController _tipoController;
  late final TextEditingController _corController;
  late final TextEditingController _marcaController;
  late final TextEditingController _fotoUrlController;

  @override
  void initState() {
    super.initState();
    _modeloController = TextEditingController(text: widget.acessorio?.modelo);
    _tipoController = TextEditingController(text: widget.acessorio?.tipo);
    _corController = TextEditingController(text: widget.acessorio?.cor);
    _marcaController = TextEditingController(text: widget.acessorio?.marca);
    _fotoUrlController = TextEditingController(text: widget.acessorio?.fotoUrl);
  }

  @override
  void dispose() {
    _modeloController.dispose();
    _tipoController.dispose();
    _corController.dispose();
    _marcaController.dispose();
    _fotoUrlController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState?.validate() ?? false) {
      final acessorioParaSalvar = DTOAcessorios(
        id: widget.acessorio?.id,
        modelo: _modeloController.text,
        tipo: _tipoController.text,
        cor: _corController.text,
        marca: _marcaController.text,
        fotoUrl: _fotoUrlController.text,
      );

      try {
        await _acessorioRepository.salvar(acessorioParaSalvar);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.acessorio == null ? 'Acessório salvo com sucesso!' : 'Acessório atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar acessório: $e'),
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
        title: Text(widget.acessorio == null ? 'Novo Acessório' : 'Editar Acessório'),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CampoTexto(
                  controller: _modeloController,
                  texto: 'modelo',
                  validator: (value) => (value == null || value.isEmpty) ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 16),
                CampoTexto(controller: _tipoController, texto: 'Tipo'),
                const SizedBox(height: 16),
                CampoTexto(controller: _corController, texto: 'Cor'),
                const SizedBox(height: 16),
                CampoTexto(controller: _marcaController, texto: 'Marca'),
                const SizedBox(height: 16),
                CampoTexto(controller: _fotoUrlController, texto: 'URL da Foto'),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Salvar', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
