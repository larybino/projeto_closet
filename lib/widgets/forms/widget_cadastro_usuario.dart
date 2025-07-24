import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dao/usuarioDAO.dart';
import 'package:projeto_lary/banco/dto/DTOUsuario.dart';
import '../componentes/campo_texto.dart';

class WidgetCadastroUsuario extends StatefulWidget {
  const WidgetCadastroUsuario({super.key});

  @override
  State<WidgetCadastroUsuario> createState() => _WidgetCadastroUsuarioState();
}

class _WidgetCadastroUsuarioState extends State<WidgetCadastroUsuario> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioDAO = UsuarioDAO();

  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmarSenhaController = TextEditingController();
  final _fotoUrlController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    _fotoUrlController.dispose();
    super.dispose();
  }

  Future<void> _cadastrar() async {
    if (_formKey.currentState?.validate() ?? false) {
      final usuarioExistente = await _usuarioDAO.buscarPorEmail(_emailController.text);
      if (usuarioExistente != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Este e-mail já está em uso.'),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      final novoUsuario = DTOUsuario(
        nome: _nomeController.text,
        email: _emailController.text,
        senha: _senhaController.text, 
        fotoPerfil: _fotoUrlController.text,
      );

      try {
        await _usuarioDAO.salvar(novoUsuario);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Cadastro realizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pushReplacementNamed('/login');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao realizar cadastro: $e'),
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
        title: const Text('Criar Conta'),
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
                CampoTexto(
                  controller: _nomeController,
                  texto: 'Nome Completo',
                  validator: (v) => (v == null || v.isEmpty) ? 'Campo obrigatório' : null,
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  controller: _emailController,
                  texto: 'E-mail',
                  tipoTeclado: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Campo obrigatório';
                    if (!v.contains('@')) return 'E-mail inválido';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  controller: _senhaController,
                  texto: 'Senha',
                  ocultarTexto: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Campo obrigatório';
                    if (v.length < 6) return 'A senha deve ter no mínimo 6 caracteres';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CampoTexto(
                  controller: _confirmarSenhaController,
                  texto: 'Confirmar Senha',
                  ocultarTexto: true,
                  validator: (v) {
                    if (v != _senhaController.text) return 'As senhas não coincidem';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                CampoTexto(controller: _fotoUrlController, texto: 'URL da Foto de Perfil (Opcional)'),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _cadastrar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Cadastrar', style: TextStyle(fontSize: 18, color: Colors.white)),
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
      ),
      ),
    );
  }
}
