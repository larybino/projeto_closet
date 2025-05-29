import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/campo_texto.dart';

class WidgetCadastroEvento extends StatefulWidget {
  @override
  State<WidgetCadastroEvento> createState() => _WidgetCadastroEventoState();
}

class _WidgetCadastroEventoState extends State<WidgetCadastroEvento> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Eventos'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Form(
        child: Column(
          children: [
            const SizedBox(height: 16),
            CampoTexto(
              'Local',
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
                  Navigator.pushNamed(context, '/');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
