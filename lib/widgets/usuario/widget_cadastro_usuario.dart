import 'package:flutter/material.dart';

class WidgetCadastroUsuario extends StatefulWidget {
  @override
  State<WidgetCadastroUsuario> createState() => _WidgetCadastroUsuarioState();
}

class _WidgetCadastroUsuarioState extends State<WidgetCadastroUsuario> {
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Usuário'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Icon(
                Icons.person,
                size: 80,
                color: Color.fromARGB(255, 243, 33, 219),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || valor.length < 3) {
                    return 'Nome deve ter ao menos 3 letras';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor == null || !valor.contains('@')) {
                    return 'Digite um email válido';
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
                    return 'Senha deve ter ao menos 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _confirmaSenhaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirmar Senha',
                  border: OutlineInputBorder(),
                ),
                validator: (valor) {
                  if (valor!= _senhaController.text) {
                    return 'Senha não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: const Text('Cadastrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cadastro realizado!')),
                      );
                      Navigator.pushNamed(context, '/');
                    }
                  },
                  )
                ),
                 const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text(
                  'Já tem conta? Faça o login',
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
