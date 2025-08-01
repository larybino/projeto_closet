import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOMala.dart';
import 'package:projeto_lary/widgets/componentes/widget_linha_detalhe.dart';

class WidgetDetalhesMala extends StatelessWidget {
  final DTOMala mala;

  const WidgetDetalhesMala({super.key, required this.mala});

  @override
  Widget build(BuildContext context) {
    final allItems = [
      ...mala.roupas,
      ...mala.sapatos,
      ...mala.acessorios,
    ];

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  mala.nome ?? '',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(height: 24),
              WidgetLinhaDetalhe(
                icon: Icons.event,
                label: 'Evento Associado',
                value: mala.evento?.nome ?? 'Nenhum',
                iconColor: const Color.fromARGB(255, 243, 33, 219),
              ),
              const SizedBox(height: 12),
              const Text(
                'Itens na Mala:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 12),
              if (allItems.isNotEmpty)
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allItems.length,
                    itemBuilder: (context, index) {
                      final item = allItems[index];
                      final imageUrl = (item as dynamic).fotoUrl;
                      final itemNome = (item as dynamic).modelo ?? (item as dynamic).nome;

                      return Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: (imageUrl != null && imageUrl.isNotEmpty)
                                    ? Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        width: 100,
                                        errorBuilder: (c, e, s) => const Icon(Icons.error, color: Colors.grey),
                                      )
                                    : Container(
                                        color: Colors.grey[200],
                                        child: const Icon(Icons.no_photography, color: Colors.grey),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              itemNome,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )
              else
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Text('Nenhum item adicionado a esta mala.'),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
