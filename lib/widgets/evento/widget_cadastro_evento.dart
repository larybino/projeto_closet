import 'package:flutter/material.dart';

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
              SizedBox(
                width: 200,
                height: 100,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Look do Evento'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color.fromARGB(255, 243, 33, 219),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Local',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Horário',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Companhia',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Ocasião',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
