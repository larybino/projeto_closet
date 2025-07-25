import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dao/MalaDAO.dart';
import 'package:projeto_lary/banco/dto/DTOMala.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_malas.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_mala.dart';

class WidgetMalas extends StatefulWidget {
  const WidgetMalas({super.key});

  @override
  State<WidgetMalas> createState() => _WidgetListaMalasState();
}

class _WidgetListaMalasState extends State<WidgetMalas> {
  final _malaDAO = MalaDAO();
  late Future<List<DTOMala>> _malasFuture;

  @override
  void initState() {
    super.initState();
    _atualizarListaMalas();
  }

  void _atualizarListaMalas() {
    setState(() {
      _malasFuture = _malaDAO.listar();
    });
  }

  void _adicionarMala() async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const WidgetCadastroMala()),
    );
    if (resultado == true) _atualizarListaMalas();
  }

  void _editarMala(DTOMala mala) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => WidgetCadastroMala(mala: mala)),
    );
    if (resultado == true) _atualizarListaMalas();
  }

  void _excluirMala(DTOMala mala) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: Text(
              'Tem a certeza de que deseja excluir a mala "${mala.nome}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () async {
                  if (mala.id != null) {
                    await _malaDAO.excluir(mala.id!);
                    Navigator.pop(ctx);
                    _atualizarListaMalas();
                  }
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

  void _mostrarDetalhes(DTOMala mala) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => WidgetDetalhesMala(mala: mala),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Malas'),
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
        child: FutureBuilder<List<DTOMala>>(
          future: _malasFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text('Erro ao carregar looks: ${snapshot.error}'),
              );
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhuma mala cadastrada.'));
            }

            final malas = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: malas.length,
              itemBuilder: (context, index) {
                final mala = malas[index];
                final totalItens =
                    mala.roupas.length +
                    mala.sapatos.length +
                    mala.acessorios.length;

                return GestureDetector(
                  onTap: () => _mostrarDetalhes(mala),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.luggage,
                        size: 40,
                        color: Color.fromARGB(255, 243, 33, 219),
                      ),
                      title: Text(
                        mala.nome,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Evento: ${mala.evento?.nome ?? "Nenhum"}\nItens: $totalItens',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editarMala(mala),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _excluirMala(mala),
                          ),
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
        onPressed: _adicionarMala,
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Criar nova mala',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
