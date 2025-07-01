import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dao/usuarioDAO.dart';
import '../campo_texto.dart'; 

class WidgetLoginUsuario extends StatefulWidget {
  const WidgetLoginUsuario({super.key});

  @override
  State<WidgetLoginUsuario> createState() => _WidgetLoginUsuarioState();
}

class _WidgetLoginUsuarioState extends State<WidgetLoginUsuario> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioDAO = UsuarioDAO();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {
        final usuario = await _usuarioDAO.buscarPorEmail(_emailController.text);

        if (usuario != null && usuario.senha == _senhaController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Bem-vindo(a), ${usuario.nome}!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pushNamedAndRemoveUntil('/menu', (route) => false, arguments: usuario);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('E-mail ou senha inválidos.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ocorreu um erro: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.checkroom, size: 80, color: Color.fromARGB(255, 243, 33, 219)),
                  const SizedBox(height: 16),
                  const Text(
                    'Meu Closet',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 243, 33, 219),
                    ),
                  ),
                  const SizedBox(height: 32),
                  CampoTexto(
                    controller: _emailController,
                    texto: 'E-mail',
                    tipoTeclado: TextInputType.emailAddress,
                    validator: (v) => (v == null || !v.contains('@')) ? 'E-mail inválido' : null,
                  ),
                  const SizedBox(height: 16),
                  CampoTexto(
                    controller: _senhaController,
                    texto: 'Senha',
                    ocultarTexto: true,
                    validator: (v) => (v == null || v.isEmpty) ? 'Campo obrigatório' : null,
                  ),
                  const SizedBox(height: 24),
                  _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text('Entrar', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ),
                  TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro');
                },
                child: const Text(
                  'Não tem conta? Faça o cadastro',
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
