import 'package:flutter/material.dart';

class WidgetCadastroAcessorios extends StatefulWidget {
  @override
  State<WidgetCadastroAcessorios> createState() => _WidgetCadastroAcessoriosState();
}

class _WidgetCadastroAcessoriosState extends State<WidgetCadastroAcessorios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Acessorios'),
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
                  label: const Text('Foto Acessórios'),
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
                  labelText: 'Estilo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Material',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Cor',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Marca',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
