import 'package:flutter/material.dart';

class WidgetLoginUsuario extends StatefulWidget {
  @override
  State<WidgetLoginUsuario> createState() => _WidgetLoginUsuarioState();
}

class _WidgetLoginUsuarioState extends State<WidgetLoginUsuario> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 240, 250),
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(
                Icons.lock_outline,
                size: 80,
                color: Color.fromARGB(255, 243, 33, 219),
              ),
              const SizedBox(height: 20),
              const Text(
                'Bem-vinda de volta!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 243, 33, 219),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || !valor.contains('@')) {
                    return 'Digite um e-mail válido';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _senhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.length < 6) {
                    return 'Senha inválida';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, '/editar_perfil');
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro_usuario');
                },
                child: const Text(
                  'Não tem conta? Cadastre-se',
                  style: TextStyle(
                    color: Color.fromARGB(255, 243, 33, 219),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
