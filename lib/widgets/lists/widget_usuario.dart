import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOUsuario.dart';
import 'package:projeto_lary/configuracao/rotas.dart';

class WidgetUsuario extends StatelessWidget {
  final DTOUsuario usuario;

  const WidgetUsuario({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white,
                backgroundImage: (usuario.fotoPerfil != null && usuario.fotoPerfil!.isNotEmpty)
                    ? NetworkImage(usuario.fotoPerfil!)
                    : null,
                child: (usuario.fotoPerfil == null || usuario.fotoPerfil!.isEmpty)
                    ? Text(
                        usuario.nome?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(fontSize: 70.0, color: Color.fromARGB(255, 243, 33, 219)),
                      )
                    : null,
              ),
              const SizedBox(height: 20),
              Text(
                usuario.nome ?? 'Nome do Usuário',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                usuario.email ?? 'email@exemplo.com',
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const Spacer(), 
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  label: const Text('Editar Perfil', style: TextStyle(fontSize: 18, color: Colors.white)),
                  onPressed: () {
                    Navigator.pushNamed(context, Rotas.editarPerfil, arguments: usuario);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 243, 33, 219),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
