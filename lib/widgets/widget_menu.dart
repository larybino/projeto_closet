import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOUsuario.dart';
import 'package:projeto_lary/widgets/componentes/widget_drawer_menu.dart';

class WidgetMenu extends StatefulWidget {
  final DTOUsuario usuario;

  const WidgetMenu({super.key, required this.usuario});

  @override
  State<WidgetMenu> createState() => _WidgetMenuState();
}

class _WidgetMenuState extends State<WidgetMenu> {
  late DTOUsuario _usuarioAtual;

  @override
  void initState() {
    super.initState();
    _usuarioAtual = widget.usuario;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Closet'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      drawer: WidgetDrawerMenu(usuario: _usuarioAtual), 
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                size: 100,
                color: const Color.fromARGB(255, 243, 33, 219),
              ),
              const SizedBox(height: 20),
              Text(
                'Bem-vinda, ${_usuarioAtual.nome}!',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Organize seu closet com facilidade.',
                style: TextStyle(fontSize: 18, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
