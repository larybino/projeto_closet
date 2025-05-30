import 'package:flutter/material.dart';

class WidgetCadastroLook extends StatefulWidget {
  @override
  State<WidgetCadastroLook> createState() => _WidgetCadastroLookState();
}

class _WidgetCadastroLookState extends State<WidgetCadastroLook> {
  var roupasSelecionadas = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Look'),
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
        child: Center(
          child: Column(
            children: [
              const Text(
                'Selecione as roupas para o look:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Look salvo com ${roupasSelecionadas.length} peças',
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                ),
                child: const Text('Salvar Look'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
