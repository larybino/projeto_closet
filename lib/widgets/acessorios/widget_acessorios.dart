import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/acessorios/widget_detalhes_acessorios.dart';

class WidgetAcessorios extends StatelessWidget {
  final acessorios = [
    {
      'estilo': 'Pulseira Life',
      'material': 'Prata',
      'cor': 'Prata',
      'marca': 'Vivara',
      'imagem':
        'https://lojavivara.vtexassets.com/arquivos/ids/2471327-1600-1600/PL00015208-1.jpg.jpg?v=638804193927070000'
    },
    {
      'estilo': 'Bolsa Noelle Transversal Tri Compartment Caramelo',
      'material': ' Poliuretano',
      'cor': 'Caramelo',
      'marca': 'Guess',
      'imagem':
        'https://guessbr.vtexassets.com/arquivos/ids/216635-1413-2048?v=638755734391400000&width=1413&height=2048&aspect=true'
    },
    {
      'estilo': 'Pulseira Life infinito',
      'material': 'Prata',
      'cor': 'Prata',
      'marca': 'Vivara',
      'imagem':
        'https://lojavivara.vtexassets.com/arquivos/ids/930609-1600-1600/Pulseira-Life-Infinito-em-Prata-925-86754_1_set.jpg?v=638745493413630000'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus acessorios'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: acessorios.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.50,
          ),
          itemBuilder: (context, index) {
            final roupa = acessorios[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WidgetDetalhesAcessorios(acessorios: acessorios);
                  },
                );
              },

              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          roupa['imagem']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          Text(
                            roupa['estilo']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            roupa['marca']!,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cadastrar_acessorios');
        },
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Adicionar nova roupa',
        child: const Icon(Icons.add),
      ),
    );
  }
}
