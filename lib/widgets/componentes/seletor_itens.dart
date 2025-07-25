import 'package:flutter/material.dart';

class WidgetSeletorDeItens<T> extends StatelessWidget {
  final String titulo;
  final Future<List<T>> future;
  final List<T> itensSelecionados;
  final String Function(T) nomeItem;
  final Function(List<T>) onSelecaoMudou;

  const WidgetSeletorDeItens({
    super.key,
    required this.titulo,
    required this.future,
    required this.itensSelecionados,
    required this.nomeItem,
    required this.onSelecaoMudou,
  });

  Future<void> _mostrarDialogoDeSelecao(BuildContext context) async {
    final todosOsItens = await future;
    final itensSelecionadosTemporariamente = List<T>.from(itensSelecionados);

    final resultado = await showDialog<List<T>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Selecionar ${titulo.toLowerCase()}'),
          content: SizedBox(
            width: double.maxFinite,
            child: StatefulBuilder(
              builder: (context, setStateDialog) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: todosOsItens.length,
                  itemBuilder: (context, index) {
                    final item = todosOsItens[index];
                    final isSelected = itensSelecionadosTemporariamente.any(
                      (i) => (i as dynamic).id == (item as dynamic).id,
                    );
                    return CheckboxListTile(
                      title: Text(nomeItem(item)),
                      value: isSelected,
                      onChanged: (bool? value) {
                        setStateDialog(() {
                          if (value == true) {
                            itensSelecionadosTemporariamente.add(item);
                          } else {
                            itensSelecionadosTemporariamente.removeWhere(
                              (i) => (i as dynamic).id == (item as dynamic).id,
                            );
                          }
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, itensSelecionadosTemporariamente),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );

    if (resultado != null) {
      onSelecaoMudou(resultado);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: itensSelecionados.map((item) {
            return Chip(
              label: Text(nomeItem(item)),
              onDeleted: () {
                final novaLista = List<T>.from(itensSelecionados)
                  ..removeWhere((i) => (i as dynamic).id == (item as dynamic).id);
                onSelecaoMudou(novaLista);
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Icon(Icons.add),
            label: Text('Selecionar ${titulo.toLowerCase()}'),
            onPressed: () => _mostrarDialogoDeSelecao(context),
          ),
        ),
      ],
    );
  }
}
