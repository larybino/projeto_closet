import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/Conexao.dart';
import 'package:projeto_lary/configuracao/aplicativo.dart';
import 'package:projeto_lary/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ConexaoSQLite.database;
  runApp(const Aplicativo());
}