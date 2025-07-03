import 'package:flutter/material.dart';
import 'package:projeto_lary/configuracao/rotas.dart';

class Aplicativo extends StatelessWidget {
  const Aplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Closet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 243, 33, 219)),
        useMaterial3: true,
      ),
      initialRoute: Rotas.home,
      onGenerateRoute: Rotas.gerarRota,
    );
  }
}
