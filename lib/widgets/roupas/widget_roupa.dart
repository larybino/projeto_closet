import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/roupas/widget_detalhes_roupas.dart';

class WidgetRoupa extends StatelessWidget {
  final List<Map<String, String>> roupas = [
    {
      'nome': 'Vestido Floral',
      'tipo': 'Vestido',
      'cor': 'Rosa',
      'marca': 'Fashion Chic',
      'imagem':
          'https://images.tcdn.com.br/img/img_prod/798207/vestido_lais_chiffon_floral_soltinho_manga_laco_e_rendas_verde_menta_3251_1_95f9f171d5986676aa584509527bb3e8.jpg',
    },
    {
      'nome': 'Blusa de Seda',
      'tipo': 'Blusa',
      'cor': 'Branco',
      'marca': 'Elegance',
      'imagem': 'https://via.placeholder.com/300x300.png?text=Blusa',
    },
    {
      'nome': 'Saia Midi',
      'tipo': 'Saia',
      'cor': 'Azul',
      'marca': 'Trendy',
      'imagem': 'https://via.placeholder.com/300x300.png?text=Saia',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Roupas'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: roupas.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.95,
          ),
          itemBuilder: (context, index) {
            final roupa = roupas[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WidgetDetalhesRoupas(roupa: roupa);
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
                            roupa['nome']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            roupa['tipo']!,
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
          Navigator.pushNamed(context, '/cadastrar_roupa');
        },
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        child: const Icon(Icons.add),
        tooltip: 'Adicionar nova roupa',
      ),
    );
  }
}
