import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';


class WidgetLook extends StatelessWidget {
  // Simulando alguns looks cadastrados
  final List<DTOLook> looksSalvos = [
    DTOLook(
      roupas: [
        DTORoupas(modelo: 'Camiseta Branca', tipo: 'Casual'),
        DTORoupas(modelo: 'Calça Jeans', tipo: 'Calça'),
      ],
      sapatos: [
        DTOSapato(modelo: 'Tênis Branco', material: 'Couro'),
      ],
      acessorios: [
        DTOAcessorios(estilo: 'Relógio', material: 'Aço'),
      ],
    ),
    DTOLook(
      roupas: [
        DTORoupas(modelo: 'Jaqueta Preta', tipo: 'Jaqueta'),
      ],
      sapatos: [
        DTOSapato(modelo: 'Bota Marrom', material: 'Couro'),
      ],
      acessorios: [
        DTOAcessorios(estilo: 'Colar Dourado',  material: 'Ouro'),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Looks Montados'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: ListView.builder(
        itemCount: looksSalvos.length,
        itemBuilder: (context, index) {
          final look = looksSalvos[index];

          return Card(
            margin: const EdgeInsets.all(10),
            color: const Color.fromARGB(255, 250, 220, 240),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Look #${index + 1}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    '👕 Roupas: ${look.roupas.map((r) => r.modelo).join(', ')}',
                  ),
                  Text(
                    '👟 Sapatos: ${look.sapatos.map((s) => s.modelo).join(', ')}',
                  ),
                  Text(
                    '💍 Acessórios: ${look.acessorios.map((a) => a.estilo).join(', ')}',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
