import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CampoFoto extends StatefulWidget {
  final TextEditingController controller;

  const CampoFoto({super.key, required this.controller});

  @override
  State<CampoFoto> createState() => _CampoFotoState();
}

class _CampoFotoState extends State<CampoFoto> {
  File? _imagemSelecionada;

  Future<void> _selecionarImagem() async {
    final picker = ImagePicker();
    final imagem = await picker.pickImage(source: ImageSource.gallery);

    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
        widget.controller.text = imagem.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_imagemSelecionada != null)
          Image.file(
            _imagemSelecionada!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          decoration: const InputDecoration(
            labelText: 'URL ou caminho da imagem',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          icon: const Icon(Icons.photo),
          label: const Text('Selecionar imagem'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 243, 33, 219),
          ),
          onPressed: _selecionarImagem,
        ),
      ],
    );
  }
}
