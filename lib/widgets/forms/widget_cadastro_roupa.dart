import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/widgets/campo_foto.dart';
import 'package:projeto_lary/widgets/campo_texto.dart';

class WidgetCadastroRoupa extends StatefulWidget {
  @override
  State<WidgetCadastroRoupa> createState() => _WidgetCadastroRoupaState();
}

class _WidgetCadastroRoupaState extends State<WidgetCadastroRoupa> {
  final _modeloController = TextEditingController();
  final _tipoController = TextEditingController();
  final _corController = TextEditingController();
  final _marcaController = TextEditingController();
  final _fotoController = TextEditingController(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Roupa'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 240, 174, 226),
            ],
          ),
        ),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 16),
              CampoFoto(controller: _fotoController),
              const SizedBox(height: 16),
              CampoTexto(
                'Modelo',
                controller: _modeloController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira o estilo.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Tipo',
                controller: _tipoController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira o material.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Cor',
                controller: _corController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira a cor.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Marca',
                controller: _marcaController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira ua marca.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Cadastrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                  ),
                  onPressed: () {
                    // ignore: unused_local_variable
                    DTORoupas roupas = DTORoupas(
                      modelo: _modeloController.text,
                      tipo: _tipoController.text,
                      cor: _corController.text,
                      marca: _marcaController.text,
                      fotoUrl: _fotoController.text,
                    );

                    Navigator.pushNamed(context, '/roupa');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
