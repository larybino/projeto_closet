import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOUsuario.dart';
import 'package:projeto_lary/repositories/usuario_repository.dart';
import 'package:projeto_lary/widgets/componentes/widget_drawer_menu.dart';
import '../componentes/campo_texto.dart';

class WidgetEditarPerfil extends StatefulWidget {
  final DTOUsuario usuario;

  const WidgetEditarPerfil({super.key, required this.usuario});

  @override
  State<WidgetEditarPerfil> createState() => _WidgetEditarPerfilState();
}

class _WidgetEditarPerfilState extends State<WidgetEditarPerfil> {
  final _formKey = GlobalKey<FormState>();
  final _usuarioRepository = UsuarioRepository();

  late final TextEditingController _nomeController;
  late final TextEditingController _emailController;
  late final TextEditingController _fotoUrlController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.usuario.nome);
    _emailController = TextEditingController(text: widget.usuario.email);
    _fotoUrlController = TextEditingController(text: widget.usuario.fotoPerfil);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _fotoUrlController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (_formKey.currentState?.validate() ?? false) {
      final usuarioAtualizado = DTOUsuario(
        id: widget.usuario.id, 
        nome: _nomeController.text,
        email: _emailController.text,
        fotoPerfil: _fotoUrlController.text,
        senha: widget.usuario.senha, 
      );

      try {
        await _usuarioRepository.salvar(usuarioAtualizado);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Perfil atualizado com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop(usuarioAtualizado);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao atualizar perfil: $e'),
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
        title: const Text('Editar Perfil'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      drawer: WidgetDrawerMenu(usuario: widget.usuario),
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
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _fotoUrlController.text.isNotEmpty
                        ? NetworkImage(_fotoUrlController.text)
                        : null,
                    child: _fotoUrlController.text.isEmpty
                        ? const Icon(Icons.person, size: 50)
                        : null,
                  ),
                ),
                const SizedBox(height: 24),
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
                  controller: _fotoUrlController,
                  texto: 'URL da Foto de Perfil',
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _salvar,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Salvar Alterações', style: TextStyle(fontSize: 18, color: Colors.white)),
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
