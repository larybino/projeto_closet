import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/sapato/widget_detalhes_sapato.dart';


class WidgetSapato extends StatelessWidget {
  final sapatos = [
    {
      'modelo': 'Scarpin Preto Verniz Salto Alto Fino',
      'material': 'Verniz',
      'cor': 'Preto',
      'marca': 'Constance',
      'imagem':
          'https://constance.vtexassets.com/arquivos/ids/2373326-1200-auto?v=638757392018200000&width=1200&height=auto&aspect=true',
    },
    {
      'modelo': 'Salto Geométrico',
      'material': 'Sintético',
      'cor': 'Preto',
      'marca': 'Vizzano',
      'imagem': 'https://static.dafiti.com.br/p/vizzano-sand%C3%A1lia-vizzano-salto-geom%C3%A9trico-preta-7306-54537441-1-zoom.jpg?ims=filters:quality(70)',
    },
    {
      'modelo': 'Sandália Meia Pata',
      'material': 'Nobuck',
      'cor': 'Preto',
      'marca': 'Modarpe',
      'imagem': 'https://static.dafiti.com.br/p/modarpe-sapato-boneca-modarpe-meia-pata-salto-alto-preto-m40-7536-38203041-1-zoom.jpg?ims=filters:quality(70)',
    },
   {
      'modelo': 'Sandália Meia Pata',
      'material': 'Nobuck',
      'cor': 'Branco',
      'marca': 'Modarpe',
      'imagem': 'https://static.dafiti.com.br/p/modarpe-sapato-boneca-modarpe-meia-pata-salto-alto-branco-m40-7535-97792041-1-zoom.jpg?ims=filters:quality(70)',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus sapatos'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: sapatos.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.50,
          ),
          itemBuilder: (context, index) {
            final sapato = sapatos[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WidgetDetalhesSapatos(sapato: sapato);
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
                          sapato['imagem']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          Text(
                            sapato['modelo']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            sapato['material']!,
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
          Navigator.pushNamed(context, '/cadastrar_sapato');
        },
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Adicionar novo sapato',
        child: const Icon(Icons.add),
      ),
    );
  }
}
