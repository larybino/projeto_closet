import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/campo_texto.dart';
import 'package:projeto_lary/widgets/usuario/DTOUsuario.dart';

class WidgetCadastroUsuario extends StatefulWidget {
  const WidgetCadastroUsuario({super.key});

  @override
  State<WidgetCadastroUsuario> createState() => _WidgetCadastroUsuarioState();
}

class _WidgetCadastroUsuarioState extends State<WidgetCadastroUsuario> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _dataNascimentoController = TextEditingController();
  final _fotoPerfilController =
      TextEditingController(); // apenas se quiser usar texto para URL
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
          key: _formKey,
          child: Column(
            children: [
              const Icon(
                Icons.person,
                size: 80,
                color: Color.fromARGB(255, 243, 33, 219),
              ),
              const SizedBox(height: 20),
              CampoTexto(
                'Nome',
                controller: _nomeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Email',
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.contains('@')) {
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
                  if (valor != _senhaController.text) {
                    return 'Senha não coincidem';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Data de Nascimento',
                controller: _dataNascimentoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data de nascimento.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CampoTexto(
                'Foto de Perfil (URL)',
                controller: _fotoPerfilController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a URL da foto de perfil.';
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
                      // Aqui você cria a instância do DTO
                      DTOUsurio usuario = DTOUsurio(
                        nome: _nomeController.text,
                        email: _emailController.text,
                        senha: _senhaController.text,
                        dataNascimento: _dataNascimentoController.text,
                        fotoPerfil: _fotoPerfilController.text,
                      );

                      // Aqui você pode usar o objeto `usuario` para salvar no banco, localStorage, API, etc.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Cadastro realizado!')),
                      );
                      Navigator.pushNamed(context, '/');
                    }
                  },
                ),
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
