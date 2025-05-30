import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/campo_texto.dart';

class WidgetCadastroAcessorios extends StatefulWidget {
  @override
  State<WidgetCadastroAcessorios> createState() =>
      _WidgetCadastroAcessoriosState();
}

class _WidgetCadastroAcessoriosState extends State<WidgetCadastroAcessorios> {
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
              CampoTexto(
                'Estilo',
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
                    Navigator.pushNamed(context, '/');
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
