import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dao/RoupaDAO.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import '../componentes/campo_texto.dart';

class WidgetCadastroRoupa extends StatefulWidget {
  final DTORoupas? roupa;

  const WidgetCadastroRoupa({super.key, this.roupa});

  @override
  State<WidgetCadastroRoupa> createState() => _WidgetCadastroRoupaState();
}

class _WidgetCadastroRoupaState extends State<WidgetCadastroRoupa> {
  final _formKey = GlobalKey<FormState>();
  final _roupaDAO = RoupaDAO();

  late final TextEditingController _modeloController;
  late final TextEditingController _tipoController;
  late final TextEditingController _corController;
  late final TextEditingController _marcaController;
  late final TextEditingController _fotoUrlController;

  @override
  void initState() {
    super.initState();
    _modeloController = TextEditingController(text: widget.roupa?.modelo);
    _tipoController = TextEditingController(text: widget.roupa?.tipo);
    _corController = TextEditingController(text: widget.roupa?.cor);
    _marcaController = TextEditingController(text: widget.roupa?.marca);
    _fotoUrlController = TextEditingController(text: widget.roupa?.fotoUrl);
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
      final roupaParaSalvar = DTORoupas(
        id: widget.roupa?.id,
        modelo: _modeloController.text,
        tipo: _tipoController.text,
        cor: _corController.text,
        marca: _marcaController.text,
        fotoUrl: _fotoUrlController.text,
      );

      try {
        await _roupaDAO.salvar(roupaParaSalvar);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.roupa == null ? 'Roupa salva com sucesso!' : 'Roupa atualizada com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true); 
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar roupa: $e'),
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
        title: Text(widget.roupa == null ? 'Nova Roupa' : 'Editar Roupa'),
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
                  texto: 'Modelo',
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
