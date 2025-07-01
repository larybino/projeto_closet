import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final String texto;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Agora é opcional
  final bool ocultarTexto;
  final TextInputType? tipoTeclado;

  const CampoTexto({
    super.key,
    required this.texto,
    this.controller,
    this.validator, // Agora é opcional
    this.ocultarTexto = false,
    this.tipoTeclado,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: ocultarTexto,
      keyboardType: tipoTeclado,
      decoration: InputDecoration(
        labelText: texto,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
