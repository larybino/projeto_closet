import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final String rotulo;
  final String? Function(String?) validator;
  final TextEditingController? controller; // <-- NOVO

  const CampoTexto(
    this.rotulo, {
    super.key,
    required this.validator,
    this.controller, // <-- NOVO
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // <-- AQUI
      decoration: InputDecoration(
        labelText: rotulo,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
