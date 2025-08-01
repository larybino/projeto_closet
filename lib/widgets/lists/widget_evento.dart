import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_lary/banco/dto/DTOEvento.dart';
import 'package:projeto_lary/repositories/evento_repository.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_evento.dart';

class WidgetEventos extends StatefulWidget {
  const WidgetEventos({super.key});

  @override
  State<WidgetEventos> createState() => _WidgetEventosState();
}

class _WidgetEventosState extends State<WidgetEventos> {
  final _eventoRepository = EventoRepository();
  late Future<List<DTOEvento>> _eventosFuture;

  @override
  void initState() {
    super.initState();
    _atualizarListaEventos();
  }

  void _atualizarListaEventos() {
    setState(() {
      _eventosFuture = _eventoRepository.listar();
    });
  }

  void _adicionarEvento() async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => const WidgetCadastroEvento()),
    );
    if (resultado == true) {
      _atualizarListaEventos();
    }
  }

  void _editarEvento(DTOEvento evento) async {
    final resultado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (context) => WidgetCadastroEvento(evento: evento)),
    );
    if (resultado == true) {
      _atualizarListaEventos();
    }
  }

  void _excluirEvento(DTOEvento evento) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Tem a certeza de que deseja excluir o evento "${evento.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _eventoRepository.excluir(evento);
                Navigator.pop(ctx);
                _atualizarListaEventos();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Evento excluído com sucesso!'),
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

  String _formatarData(String? dataIso) {
    if (dataIso == null || dataIso.isEmpty) {
      return 'Sem data';
    }
    try {
      final data = DateTime.parse(dataIso);
      return DateFormat('dd/MM/yyyy').format(data);
    } catch (e) {
      return 'Data inválida';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Eventos'),
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
        child: FutureBuilder<List<DTOEvento>>(
          future: _eventosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro ao carregar eventos: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Nenhum evento cadastrado.',
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            final eventos = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: eventos.length,
              itemBuilder: (context, index) {
                final evento = eventos[index];
                final look = evento.look;
                final allImageUrls = look != null ? [
                  ...look.roupas.map((r) => r.fotoUrl),
                  ...look.sapatos.map((s) => s.fotoUrl),
                  ...look.acessorios.map((a) => a.fotoUrl),
                ].where((url) => url != null && url.isNotEmpty).toList() : [];

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Color.fromARGB(255, 243, 33, 219)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                evento.nome ?? 'Evento sem nome',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editarEvento(evento),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _excluirEvento(evento),
                            ),
                          ],
                        ),
                        Text(
                          _formatarData(evento.data),
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black54),
                        ),
                        const Divider(height: 20),
                        Text(
                          'Look: ${look?.nome ?? "Nenhum look associado"}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        if (allImageUrls.isNotEmpty)
                          SizedBox(
                            height: 70,
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
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.cover,
                                      errorBuilder: (c, e, s) => const Icon(Icons.error),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        else if (look != null)
                          const Text('Este look não possui itens com imagem.'),
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
        onPressed: _adicionarEvento,
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
        tooltip: 'Adicionar novo evento',
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
