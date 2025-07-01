import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/sapato/DTOSapato.dart';
import 'package:projeto_lary/widgets/sapato/widget_detalhes_sapato.dart';

class WidgetSapato extends StatefulWidget {
  const WidgetSapato({Key? key}) : super(key: key);

  @override
  _WidgetSapatoState createState() => _WidgetSapatoState();
}

class _WidgetSapatoState extends State<WidgetSapato> {
  final List<DTOSapato> sapatos = [
    DTOSapato(
      id: '1',
      modelo: 'Scarpin Preto Verniz Salto Alto Fino',
      material: 'Verniz',
      cor: 'Preto',
      marca: 'Constance',
      fotoUrl:
          'https://constance.vtexassets.com/arquivos/ids/2373326-1200-auto?v=638757392018200000&width=1200&height=auto&aspect=true',
    ),
    DTOSapato(
      id: '2',
      modelo: 'Salto Geométrico',
      material: 'Sintético',
      cor: 'Preto',
      marca: 'Vizzano',
      fotoUrl:
          'https://static.dafiti.com.br/p/vizzano-sand%C3%A1lia-vizzano-salto-geom%C3%A9trico-preta-7306-54537441-1-zoom.jpg?ims=filters:quality(70)',
    ),
    DTOSapato(
      id: '3',
      modelo: 'Sandália Meia Pata',
      material: 'Nobuck',
      cor: 'Preto',
      marca: 'Modarpe',
      fotoUrl:
          'https://static.dafiti.com.br/p/modarpe-sapato-boneca-modarpe-meia-pata-salto-alto-preto-m40-7536-38203041-1-zoom.jpg?ims=filters:quality(70)',
    ),
    DTOSapato(
      id: '4',
      modelo: 'Sandália Meia Pata',
      material: 'Nobuck',
      cor: 'Branco',
      marca: 'Modarpe',
      fotoUrl:
          'https://static.dafiti.com.br/p/modarpe-sapato-boneca-modarpe-meia-pata-salto-alto-branco-m40-7535-97792041-1-zoom.jpg?ims=filters:quality(70)',
    ),
  ];

  void alterar(DTOSapato sapato) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alterar: ${sapato.modelo} - ${sapato.marca}')),
    );
  }

  void excluir(DTOSapato sapato) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirmar exclusão'),
            content: Text('Deseja excluir "${sapato.modelo}"?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Excluído: ${sapato.modelo}')),
                  );
                  // Se fosse uma lista dinâmica, removeria aqui
                },
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

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
                        child:
                            sapato.fotoUrl != null
                                ? Image.network(
                                  sapato.fotoUrl!,
                                  fit: BoxFit.cover,
                                )
                                : const Icon(Icons.image_not_supported),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          Text(
                            sapato.modelo ?? 'Sem modelo',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            sapato.material ?? 'Sem material',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ButtonBar(
                        alignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () => alterar(sapato),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => excluir(sapato),
                          ),
                        ],  
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
