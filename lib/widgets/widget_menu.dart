import 'package:flutter/material.dart';
import 'package:projeto_lary/configuracao/rotas.dart';

class WidgetMenu extends StatelessWidget {
  const WidgetMenu({super.key});

  @override
  Widget build(BuildContext context) {

    Widget criarMenu({required IconData icone,required String rotulo,required String rota}){
      return ListTile(
        leading: Icon(icone),
        title: Text(rotulo),
        onTap: () => Navigator.pushNamed(context, rota),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Closet'),
        backgroundColor: Color.fromARGB(255, 243, 33, 219),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 33, 219),
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            criarMenu(icone: Icons.coffee_outlined, rotulo: 'Cadastro de Roupas', rota: Rotas.roupa),
            criarMenu(icone: Icons.ring_volume, rotulo: 'Cadastro de Acessorios', rota: Rotas.acessorios),
            criarMenu(icone: Icons.person, rotulo: 'Cadastro de Looks', rota: Rotas.look),
            criarMenu(icone: Icons.store, rotulo: 'Cadastro de Marcas', rota: Rotas.marca),
            criarMenu(icone: Icons.event, rotulo: 'Cadastro de Eventos', rota: Rotas.evento),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao Meu Closet!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: ListTile(
                  title: const Text('Login'),
                  leading: const Icon(Icons.person),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cadastro_usuario');
                },
                child: ListTile(
                  title: const Text('Cadastra-se'),
                  leading: const Icon(Icons.person),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
