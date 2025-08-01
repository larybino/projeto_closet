import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/repositories/look_repository.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_look.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_look.dart';

class WidgetLook extends StatefulWidget {
  const WidgetLook({super.key});

  @override
  State<WidgetLook> createState() => _WidgetLookState();
}

class _WidgetLookState extends State<WidgetLook> {
  final _lookRepository = LookRepository();
  late Future<List<DTOLook>> _looksFuture;

  @override
  void initState() {
    super.initState();
    _atualizarListaLooks();
  }

  void _atualizarListaLooks() {
    setState(() {
      _looksFuture = _lookRepository.listar();
    });
  }

  void _adicionarLook() async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const WidgetCadastroLook()),
    );
    if (resultado == true) {
      _atualizarListaLooks();
    }
  }

  void _editarLook(DTOLook look) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => WidgetCadastroLook(look: look)),
    );
    if (resultado == true) {
      _atualizarListaLooks();
    }
  }

  void _excluirLook(DTOLook look) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem a certeza de que deseja excluir o look "${look.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _lookRepository.excluir(look);
                Navigator.pop(ctx);
                _atualizarListaLooks();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Look excluído com sucesso!'),
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

  void _mostrarDetalhes(DTOLook look) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      backgroundColor: Colors.transparent,
      builder: (context) {
        return WidgetDetalhesLook(look: look);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Looks'),
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
        child: FutureBuilder<List<DTOLook>>(
          future: _looksFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar looks: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum look cadastrado.'));
            }

            final looks = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: looks.length,
              itemBuilder: (context, index) {
                final look = looks[index];
                
                final allImageUrls = [
                  ...look.roupas.map((r) => r.fotoUrl),
                  ...look.sapatos.map((s) => s.fotoUrl),
                  ...look.acessorios.map((a) => a.fotoUrl),
                ].where((url) => url != null && url.isNotEmpty).toList();
                
                return GestureDetector(
                  onTap: () => _mostrarDetalhes(look),
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  look.nome ?? 'Look sem nome',
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () => _editarLook(look),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _excluirLook(look),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          if (allImageUrls.isNotEmpty)
                            SizedBox(
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: allImageUrls.length,
                                itemBuilder: (ctx, imgIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        allImageUrls[imgIndex]!,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder: (c, e, s) => const Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          else
                            const Text('Este look não possui itens com imagem.'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _adicionarLook,
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Adicionar novo look',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
