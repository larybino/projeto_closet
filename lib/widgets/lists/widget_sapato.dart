import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:projeto_lary/repositories/sapato_repository.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_sapato.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_sapato.dart';


class WidgetSapato extends StatefulWidget {
  const WidgetSapato({super.key});

  @override
  State<WidgetSapato> createState() => _WidgetSapatoState();
}

class _WidgetSapatoState extends State<WidgetSapato> {
  final _sapatoRepository = SapatoRepository();
  late Future<List<DTOSapato>> _sapatosFuture;

  @override
  void initState() {
    super.initState();
    _atualizarListaSapatos();
  }

  void _atualizarListaSapatos() {
    setState(() {
      _sapatosFuture = _sapatoRepository.listar();
    });
  }

  void _adicionarSapato() async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const WidgetCadastroSapato()),
    );
    if (resultado == true) {
      _atualizarListaSapatos();
    }
  }

  void _editarSapato(DTOSapato sapato) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => WidgetCadastroSapato(sapato: sapato)),
    );
    if (resultado == true) {
      _atualizarListaSapatos();
    }
  }

  void _excluirSapato(DTOSapato sapato) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem a certeza de que deseja excluir o sapato "${sapato.modelo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _sapatoRepository.excluir(sapato);
                Navigator.pop(ctx);
                _atualizarListaSapatos();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sapato excluído com sucesso!'),
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
        title: const Text('Meus Sapatos'),
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
        child: FutureBuilder<List<DTOSapato>>(
          future: _sapatosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar sapatos: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum sapato cadastrado.'));
            }

            final sapatos = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: sapatos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final sapato = sapatos[index];
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => WidgetDetalhesSapatos(sapato: sapato),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: (sapato.fotoUrl != null && sapato.fotoUrl!.isNotEmpty)
                              ? Image.network(
                                  sapato.fotoUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                )
                              : const Icon(Icons.ice_skating, size: 80, color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            sapato.modelo ?? 'Sem modelo',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editarSapato(sapato),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _excluirSapato(sapato),
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
        onPressed: _adicionarSapato,
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Adicionar novo sapato',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
