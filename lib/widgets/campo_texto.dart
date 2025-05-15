import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget {
  final String rotulo;
  final String? Function(String?) validator;

  const CampoTexto(
    this.rotulo, {
    super.key,
   required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: rotulo, border: OutlineInputBorder(),
      ),
      validator: validator
    );
  }
}
