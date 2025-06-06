import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/campo_texto.dart';
import 'package:projeto_lary/widgets/evento/DTOEvento.dart';

class WidgetCadastroEvento extends StatefulWidget {
  const WidgetCadastroEvento({super.key});

  @override
  State<WidgetCadastroEvento> createState() => _WidgetCadastroEventoState();
}

class _WidgetCadastroEventoState extends State<WidgetCadastroEvento> {
  final __localController = TextEditingController();
  final __horarioController = TextEditingController();
  final __companhiaController = TextEditingController();
  final __ocasiaoController = TextEditingController();

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
        child:Form(
        child: Column(
          children: [
            const SizedBox(height: 16),
            CampoTexto(
              'Local',
              controller: __localController,
              validator: (value) {
                // if (value == null || value.isEmpty) {
                //   return 'Por favor, insira um local.';
                // }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CampoTexto(
              'Horário',
              controller: __horarioController,
              validator: (value) {
                // if (value == null || value.isEmpty) {
                //   return 'Por favor, insira um horário.';
                // }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CampoTexto(
              'Companhia',
              controller: __companhiaController,
              validator: (value) {
                // if (value == null || value.isEmpty) {
                //   return 'Por favor, insira a companhia.';
                // }
                return null;
              },
            ),
            const SizedBox(height: 16),
            CampoTexto(
              'Ocasião',
              controller: __ocasiaoController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira a ocasião.';
                }
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
                    local: __localController.text,
                    horario: __horarioController.text,
                    companhia: __companhiaController.text,
                    ocasiao: __ocasiaoController.text,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),);
  }
}
