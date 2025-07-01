import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/widgets/campo_texto.dart';
import 'package:projeto_lary/banco/dto/DTOEvento.dart';

class WidgetCadastroEvento extends StatefulWidget {
  const WidgetCadastroEvento({super.key});

  @override
  State<WidgetCadastroEvento> createState() => _WidgetCadastroEventoState();
}

class _WidgetCadastroEventoState extends State<WidgetCadastroEvento> {
  final __nomeController = TextEditingController();
  final __dataController = TextEditingController();
  final __lookController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Eventos'),
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
              CampoTexto(
                'Nome',
                controller: __nomeController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira um local.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Data',
                controller: __dataController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira um horário.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Look',
                controller: __lookController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira a companhia.';
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
                    DTOEvento evento = DTOEvento(
                      nome: __nomeController.text,
                      data: __dataController.text,
                    );

                    Navigator.pushNamed(context, '/evento');
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
