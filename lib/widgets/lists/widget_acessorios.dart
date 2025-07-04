import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dao/acessorioDAO.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_acessorios.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_acessorios.dart';


class WidgetAcessorios extends StatefulWidget {
  const WidgetAcessorios({super.key});

  @override
  State<WidgetAcessorios> createState() => _WidgetAcessoriosState();
}

class _WidgetAcessoriosState extends State<WidgetAcessorios> {
  final _acessorioDAO = AcessorioDAO();
  late Future<List<DTOAcessorios>> _acessoriosFuture;

  @override
  void initState() {
    super.initState();
    _atualizarListaAcessorios();
  }

  void _atualizarListaAcessorios() {
    setState(() {
      _acessoriosFuture = _acessorioDAO.listar();
    });
  }

  void _adicionarAcessorio() async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const WidgetCadastroAcessorios()),
    );
    if (resultado == true) {
      _atualizarListaAcessorios();
    }
  }

  void _editarAcessorio(DTOAcessorios acessorio) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => WidgetCadastroAcessorios(acessorio: acessorio)),
    );
    if (resultado == true) {
      _atualizarListaAcessorios();
    }
  }

  void _excluirAcessorio(DTOAcessorios acessorio) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem a certeza de que deseja excluir o acessório "${acessorio.modelo}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              final id = int.tryParse(acessorio.id ?? '');
              if (id != null) {
                await _acessorioDAO.excluir(id);
                Navigator.pop(ctx);
                _atualizarListaAcessorios();
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
        title: const Text('Meus Acessórios'),
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
        child: FutureBuilder<List<DTOAcessorios>>(
          future: _acessoriosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar acessórios: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum acessório cadastrado.'));
            }

            final acessorios = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: acessorios.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final acessorio = acessorios[index];
                return GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => WidgetDetalhesAcessorios(acessorio: acessorio),
                    );
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: (acessorio.fotoUrl != null && acessorio.fotoUrl!.isNotEmpty)
                              ? Image.network(
                                  acessorio.fotoUrl!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                )
                              : const Icon(Icons.watch, size: 80, color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            acessorio.modelo ?? 'Sem nome',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editarAcessorio(acessorio),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _excluirAcessorio(acessorio),
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
        onPressed: _adicionarAcessorio,
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Adicionar novo acessório',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
