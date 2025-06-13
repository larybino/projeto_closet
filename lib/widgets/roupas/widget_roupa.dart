import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/roupas/widget_detalhes_roupas.dart';
import 'package:projeto_lary/widgets/roupas/DTORoupas.dart';

class WidgetRoupa extends StatefulWidget {
  const WidgetRoupa({super.key});

  @override
  _WidgetRoupaState createState() => _WidgetRoupaState();
}


class _WidgetRoupaState extends State<WidgetRoupa> {
  final List<DTORoupas> roupas = [
    DTORoupas(
      id: '1',
      modelo: 'Vestido Floral',
      tipo: 'Vestido',
      cor: 'Multicolorido',
      marca: 'Farm',
      fotoUrl:
          'https://lojafarm.vteximg.com.br/arquivos/ids/3411470/331280_49147_1-VESTIDO-LONGO-FLORAL-DE-VERAO.jpg?v=638590753519000000',
    ),

    DTORoupas(
      id: '2',
      modelo: 'Calça Flare Canelada',
      tipo: 'Calça',
      cor: 'Preta',
      marca: 'Prada',
      fotoUrl:
          'data:image/jpeg;base64,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',
    ),
    DTORoupas(
      id: '3',
      modelo: 'Vestido de tricô plissado',
      tipo: 'Vestido',
      cor: 'Vermelho',
      marca: 'Balmain',
      fotoUrl:
          'https://cdn11.bigcommerce.com/s-2w3d34av6x/images/stencil/1280x1280/products/12889/77298/grrly-grrls-crimson-elegance-turtleneck-gown__05612.1734861376.jpg?c=1',
    ),
    DTORoupas(
      id: '4',
      modelo: 'Saia xadrez cintura alta',
      tipo: 'Saia',
      cor: 'Xadrez',
      marca: 'Miu Miu',
      fotoUrl:
          'data:image/jpeg;base64,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',
    ),
  ];

  void alterar(DTORoupas roupa) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Alterar: ${roupa.modelo} - ${roupa.marca}')),
    );
  }

  void excluir(DTORoupas roupa) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: Text('Deseja excluir "${roupa.modelo}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancelar')),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Excluído: ${roupa.modelo}')),
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
        title: const Text('Minhas Roupas'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: roupas.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.50,
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
                        child:
                            roupa.fotoUrl != null
                                ? Image.network(
                                  roupa.fotoUrl!,
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
                            roupa.modelo ?? 'Sem modelo',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            roupa.tipo ?? '',
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
                            onPressed: () => alterar(roupa),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => excluir(roupa),
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
          Navigator.pushNamed(context, '/cadastrar_roupa');
        },
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Adicionar nova roupa',
        child: const Icon(Icons.add),
      ),
    );
  }
}
