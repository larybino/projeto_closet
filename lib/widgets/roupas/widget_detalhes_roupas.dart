import 'package:flutter/material.dart';

class WidgetDetalhesRoupas extends StatelessWidget {
  final roupa;

  const WidgetDetalhesRoupas({Key? key, required this.roupa}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              roupa['imagem'] ?? '',
              height: 500,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          Text('Modelo: ${roupa['modelo']}', style: TextStyle(fontSize: 18)),
          Text('Tipo: ${roupa['tipo']}', style: TextStyle(fontSize: 18)),
          Text('Cor: ${roupa['cor']}', style: TextStyle(fontSize: 18)),
          Text('Marca: ${roupa['marca']}', style: TextStyle(fontSize: 18)),
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
