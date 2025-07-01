import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_acessorios.dart';

class WidgetAcessorios extends StatefulWidget {
  const WidgetAcessorios({Key? key}) : super(key: key);

  @override
  _WidgetAcessoriosState createState() => _WidgetAcessoriosState();
}

class _WidgetAcessoriosState extends State<WidgetAcessorios> {
  final List<DTOAcessorios> acessorios = [
    DTOAcessorios(
      estilo: 'Pulseira Life',
      material: 'Prata',
      cor: 'Prata',
      marca: 'Vivara',
      fotoUrl:
          'https://lojavivara.vtexassets.com/arquivos/ids/2471327-1600-1600/PL00015208-1.jpg.jpg?v=638804193927070000',
    ),
    DTOAcessorios(
      estilo: 'Bolsa Noelle Transversal Tri Compartment Caramelo',
      material: ' Poliuretano',
      cor: 'Caramelo',
      marca: 'Guess',
      fotoUrl:
          'https://guessbr.vtexassets.com/arquivos/ids/216635-1413-2048?v=638755734391400000&width=1413&height=2048&aspect=true',
    ),
    DTOAcessorios(
      estilo: 'Pulseira Life infinito',
      material: 'Prata',
      cor: 'Prata',
      marca: 'Vivara',
      fotoUrl:
          'https://lojavivara.vtexassets.com/arquivos/ids/930609-1600-1600/Pulseira-Life-Infinito-em-Prata-925-86754_1_set.jpg?v=638745493413630000',
    ),
  ];

   void alterar(DTOAcessorios acessorio){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alterar: ${acessorio.estilo} - ${acessorio.marca}')),
    );
  }

  void excluir(DTOAcessorios acessorio){
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja excluir "${acessorio.estilo}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excluído: ${acessorio.estilo}')),
              );
              // Se fosse uma lista dinâmica, removeria aqui
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
            final acessorio = acessorios[index];
            return GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return WidgetDetalhesAcessorios(acessorios: acessorio);
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
                            acessorio.fotoUrl != null
                                ? Image.network(
                                  acessorio.fotoUrl!,
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
                            acessorio.estilo ?? 'Estilo não disponível',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            acessorio.marca ?? 'Marca não disponível',
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
                            onPressed: () => alterar(acessorio),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => excluir(acessorio),
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
          Navigator.pushNamed(context, '/cadastrar_acessorios');
        },
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Adicionar nova acessorio',
        child: const Icon(Icons.add),
      ),
    );
  }
}
