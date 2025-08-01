import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lary/configuracao/rotas.dart';
import 'package:projeto_lary/repositories/usuario_repository.dart';
import '../componentes/campo_texto.dart'; 

class WidgetLoginUsuario extends StatefulWidget {
  const WidgetLoginUsuario({super.key});

  @override
  State<WidgetLoginUsuario> createState() => _WidgetLoginUsuarioState();
}

class _WidgetLoginUsuarioState extends State<WidgetLoginUsuario> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioRepository = UsuarioRepository();
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
        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _senhaController.text,
        );

        if (userCredential.user != null) {
          final usuario = await _usuarioRepository.buscarPorId(userCredential.user!.uid);

          if (usuario != null) {
            Navigator.of(context).pushNamedAndRemoveUntil(Rotas.menu, (route) => false, arguments: usuario);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dados de perfil não encontrados.')),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'E-mail ou senha inválidos.')),
        );
      } finally {
        setState(() => _isLoading = false);
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
        child: Container(
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
      ),
    );
  }
}
