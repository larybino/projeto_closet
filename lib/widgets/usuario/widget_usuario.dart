import 'package:flutter/material.dart';

class WidgetUsuario extends StatelessWidget {
  final String nome = 'Nome/Apelido';
  final String email = '@email';
  final String dataNascimento = 'DD/MM/AAAA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Perfil'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 100,
              backgroundColor: Color.fromARGB(255, 243, 33, 219),
              child: Icon(Icons.person, size: 140, color: Colors.white),
            ),
            const SizedBox(height: 16),
            Text(
              nome,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Text('Nascimento: $dataNascimento'),

            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(
                Icons.edit,
                color: Color.fromARGB(255, 243, 33, 219),
              ),
              title: const Text('Editar Perfil'),
              onTap: () {
                Navigator.pushNamed(context, '/editar_perfil');
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.lock,
                color: Color.fromARGB(255, 243, 33, 219),
              ),
              title: const Text('Alterar Senha'),
              onTap: () {
                Navigator.pushNamed(context, '/alterar_senha');
              },
            ),
            const Spacer(),
            ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Sair'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}
