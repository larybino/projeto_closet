import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';

class WidgetDetalhesAcessorios extends StatelessWidget {
  final DTOAcessorios acessorios;

  const WidgetDetalhesAcessorios({Key? key, required this.acessorios}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
     return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              acessorios.fotoUrl?? '',
              height: 500,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 24),
          Text('Estilo: ${acessorios.estilo}', style: TextStyle(fontSize: 18)),
          Text('Material: ${acessorios.material}', style: TextStyle(fontSize: 18)),
          Text('Cor: ${acessorios.cor}', style: TextStyle(fontSize: 18)),
          Text('Marca: ${acessorios.marca}', style: TextStyle(fontSize: 18)),
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