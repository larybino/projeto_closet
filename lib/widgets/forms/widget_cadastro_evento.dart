import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projeto_lary/banco/dto/DTOEvento.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/repositories/evento_repository.dart';
import 'package:projeto_lary/repositories/look_repository.dart'; 


class WidgetCadastroEvento extends StatefulWidget {
  final DTOEvento? evento;

  const WidgetCadastroEvento({super.key, this.evento});

  @override
  State<WidgetCadastroEvento> createState() => _WidgetCadastroEventoState();
}

class _WidgetCadastroEventoState extends State<WidgetCadastroEvento> {
  final _formKey = GlobalKey<FormState>();
  final _eventoRepository = EventoRepository();

  late final TextEditingController _nomeController;
  late final TextEditingController _dataController;
  
  late Future<List<DTOLook>> _looksFuture;
  DTOLook? _lookSelecionado;
  DateTime? _dataSelecionada;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.evento?.nome);
    _dataController = TextEditingController();
    
    if (widget.evento != null) {
      _lookSelecionado = widget.evento!.look;
      if (widget.evento!.data != null) {
        _dataSelecionada = DateTime.tryParse(widget.evento!.data!);
        if (_dataSelecionada != null) {
          _dataController.text = DateFormat('dd/MM/yyyy').format(_dataSelecionada!);
        }
      }
    }
    
    _looksFuture = LookRepository().listar();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (data != null) {
      setState(() {
        _dataSelecionada = data;
        _dataController.text = DateFormat('dd/MM/yyyy').format(data);
      });
    }
  }

  Future<void> _salvar() async {
    if (_formKey.currentState?.validate() ?? false) {
      final eventoParaSalvar = DTOEvento(
        id: widget.evento?.id,
        nome: _nomeController.text,
        data: _dataSelecionada?.toIso8601String(),
        look: _lookSelecionado,
      );

      try {
        await _eventoRepository.salvar(eventoParaSalvar);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.evento == null ? 'Evento salvo com sucesso!' : 'Evento atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(true);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao salvar evento: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.evento == null ? 'Novo Evento' : 'Editar Evento'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body:Container(
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
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    labelText: 'Nome do Evento',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => (v == null || v.isEmpty) ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dataController,
                  decoration: const InputDecoration(
                    labelText: 'Data do Evento',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: _selecionarData,
                  validator: (v) => (v == null || v.isEmpty) ? 'Selecione uma data' : null,
                ),
                const SizedBox(height: 16),

                FutureBuilder<List<DTOLook>>(
                  future: _looksFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Text('Erro ao carregar looks: ${snapshot.error}');
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('Nenhum look cadastrado para selecionar.');
                    }

                    final looks = snapshot.data!;
                    return DropdownButtonFormField<DTOLook>(
                      value: _lookSelecionado,
                      decoration: const InputDecoration(
                        labelText: 'Look para o Evento (Opcional)',
                        border: OutlineInputBorder(),
                      ),
                      items: looks.map((look) {
                        return DropdownMenuItem<DTOLook>(
                          value: look,
                          child: Text(look.nome ?? 'Look sem nome'),
                        );
                      }).toList(),
                      onChanged: (DTOLook? newValue) {
                        setState(() {
                          _lookSelecionado = newValue;
                        });
                      },
                    );
                  },
                ),
                
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Salvar', style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
