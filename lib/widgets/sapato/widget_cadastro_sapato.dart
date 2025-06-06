import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/campo_texto.dart';
import 'package:projeto_lary/widgets/sapato/DTOSapato.dart';

class WidgetCadastroSapato extends StatefulWidget {
  const WidgetCadastroSapato({super.key});

  @override
  State<WidgetCadastroSapato> createState() => _WidgetCadastroSapatoState();
}

class _WidgetCadastroSapatoState extends State<WidgetCadastroSapato> {
  final _modeloController = TextEditingController();
  final _materialController = TextEditingController();
  final _corController = TextEditingController();
  final _marcaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Sapatos'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 240, 174, 226),
            ],
          ),
        ),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                height: 100,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Foto Sapato'),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      const Color.fromARGB(255, 243, 33, 219),
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Modelo',
                controller: _modeloController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira o estilo.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Material',
                controller: _materialController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira o material.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Cor',
                controller: _corController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira a cor.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Marca',
                controller: _marcaController,
                validator: (value) {
                  // if (value == null || value.isEmpty) {
                  //   return 'Por favor, insira ua marca.';
                  // }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Cadastrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                  ),
                  onPressed: () {
                    // ignore: unused_local_variable
                    DTOSapato sapato = DTOSapato(
                      modelo: _modeloController.text,
                      material: _materialController.text,
                      cor: _corController.text,
                      marca: _marcaController.text,
                      // fotoUrl: você pode adicionar futuramente se implementar upload de imagem
                    );

                    // Aqui você pode salvar o DTO em uma lista, banco, API, etc.
                    Navigator.pushNamed(context, '/sapato');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
