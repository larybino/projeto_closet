import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/repositories/roupa_repository.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_roupa.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_roupas.dart';

class WidgetRoupa extends StatefulWidget {
  const WidgetRoupa({super.key});

  @override
  State<WidgetRoupa> createState() => _WidgetRoupaState();
}

class _WidgetRoupaState extends State<WidgetRoupa> {
  final _roupaRepository = RoupaRepository();
  late Future<List<DTORoupas>> _roupasFuture;

  @override
  void initState() {
    super.initState();
    _atualizarListaRoupas();
  }

  void _atualizarListaRoupas() {
    setState(() {
      _roupasFuture = _roupaRepository.listar();
    });
  }

  void _adicionarRoupa() async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const WidgetCadastroRoupa()),
    );
    if (resultado == true) {
      _atualizarListaRoupas();
    }
  }

  void _editarRoupa(DTORoupas roupa) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => WidgetCadastroRoupa(roupa: roupa)),
    );
    if (resultado == true) {
      _atualizarListaRoupas();
    }
  }

  void _excluirRoupa(DTORoupas roupa) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem a certeza de que deseja excluir a peça "${roupa.modelo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _roupaRepository.excluir(roupa);
                Navigator.pop(ctx);
                _atualizarListaRoupas();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Peça excluída com sucesso!'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Erro ao excluir peça: $e')),
                );
              }
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 240, 174, 226),
            ],
          ),
        ),
        child: FutureBuilder<List<DTORoupas>>(
          future: _roupasFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar roupas: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhuma roupa cadastrada.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            final roupas = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: roupas.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final roupa = roupas[index];
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => WidgetDetalhesRoupas(roupa: roupa),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: (roupa.fotoUrl != null && roupa.fotoUrl!.isNotEmpty)
                              ? Image.network(
                                  roupa.fotoUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                )
                              : const Icon(Icons.checkroom, size: 80, color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            roupa.modelo ?? 'Sem modelo',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editarRoupa(roupa),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _excluirRoupa(roupa),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarRoupa,
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Adicionar nova roupa',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
