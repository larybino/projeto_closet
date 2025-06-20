import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/acessorios/DTOAcessorios.dart';
import 'package:projeto_lary/widgets/campo_foto.dart';
import 'package:projeto_lary/widgets/campo_texto.dart';

class WidgetCadastroAcessorios extends StatefulWidget {
  const WidgetCadastroAcessorios({super.key});

  @override
  State<WidgetCadastroAcessorios> createState() =>
      _WidgetCadastroAcessoriosState();
}

class _WidgetCadastroAcessoriosState extends State<WidgetCadastroAcessorios> {
  final __estiloController = TextEditingController();
  final __materialController = TextEditingController();
  final __corController = TextEditingController();
  final __marcaController = TextEditingController();
  final __fotoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Acessorios'),
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
              CampoFoto(controller: __fotoController),
              const SizedBox(height: 16),
              CampoTexto(
                'Estilo',
                controller: __estiloController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira o estilo.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Material',
                controller: __materialController,
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
                controller: __corController,
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
                controller: __marcaController,
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
                    DTOAcessorios acessorio = DTOAcessorios(
                      estilo: __estiloController.text,
                      material: __materialController.text,
                      cor: __corController.text,
                      marca: __marcaController.text,
                      fotoUrl: __fotoController.text,
                    );

                    Navigator.pushNamed(context, '/acessorio');
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
