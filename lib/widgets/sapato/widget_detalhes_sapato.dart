import 'package:flutter/material.dart';

class WidgetDetalhesSapatos extends StatelessWidget {
  final sapato;

  const WidgetDetalhesSapatos({Key? key, required this.sapato}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              sapato['imagem'] ?? '',
              height: 500,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          Text('Nome: ${sapato['nome']}', style: TextStyle(fontSize: 18)),
          Text('Material: ${sapato['material']}', style: TextStyle(fontSize: 18)),
          Text('Cor: ${sapato['cor']}', style: TextStyle(fontSize: 18)),
          Text('Marca: ${sapato['marca']}', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Fechar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 243, 33, 219),
            ),
          ),
        ],
    );
  }
}
