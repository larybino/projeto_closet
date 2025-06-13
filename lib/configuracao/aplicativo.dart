import 'package:flutter/material.dart';
import 'package:projeto_lary/configuracao/rotas.dart';
import 'package:projeto_lary/widgets/acessorios/widget_acessorios.dart';
import 'package:projeto_lary/widgets/acessorios/widget_cadastro_acessorios.dart';
import 'package:projeto_lary/widgets/evento/widget_cadastro_evento.dart';
import 'package:projeto_lary/widgets/look/widget_cadastro_look.dart';
import 'package:projeto_lary/widgets/roupas/DTORoupas.dart';
import 'package:projeto_lary/widgets/roupas/widget_cadastro_roupa.dart';
import 'package:projeto_lary/widgets/roupas/widget_detalhes_roupas.dart';
import 'package:projeto_lary/widgets/roupas/widget_roupa.dart';
import 'package:projeto_lary/widgets/sapato/widget_cadastro_sapato.dart';
import 'package:projeto_lary/widgets/sapato/widget_detalhes_sapato.dart';
import 'package:projeto_lary/widgets/sapato/widget_sapato.dart';
import 'package:projeto_lary/widgets/usuario/widget_cadastro_usuario.dart';
import 'package:projeto_lary/widgets/usuario/widget_editar_perfil.dart';
import 'package:projeto_lary/widgets/usuario/widget_login_usuario.dart';
import 'package:projeto_lary/widgets/usuario/widget_usuario.dart';
import 'package:projeto_lary/widgets/widget_telaInicial.dart';

class Aplicativo extends StatelessWidget{
  const Aplicativo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Closet',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routes:{
        Rotas.home: (context) => const WidgetTelaInicial(),
        Rotas.login: (context) =>  WidgetLoginUsuario(), 
        Rotas.cadastro: (context) =>  WidgetCadastroUsuario(),
        Rotas.usuario:(context)=> WidgetUsuario(),
        Rotas.editarPerfil:(context)=> WidgetEditarPerfil(),
        Rotas.roupa:(context)=> WidgetRoupa(),
        Rotas.acessorio:(context)=> WidgetAcessorios(),
        Rotas.sapato:(context)=> WidgetSapato(),
        Rotas.detalhesRoupas:(context)=> WidgetDetalhesRoupas(roupa: DTORoupas()), // Replace with a valid DTORoupas object
        Rotas.cadastrarRoupa:(context)=> WidgetCadastroRoupa(),
        Rotas.cadastrarAcessorios:(context)=> WidgetCadastroAcessorios(),
        Rotas.cadastrarLook:(context)=> WidgetCadastroLook(),
        Rotas.cadastrarEvento:(context)=> WidgetCadastroEvento(),
        Rotas.detalhesEvento:(context)=> WidgetCadastroEvento(),
        Rotas.detalhesLook:(context)=> WidgetCadastroLook(),
        Rotas.detalhesAcessorios:(context)=> WidgetCadastroAcessorios(),
        Rotas.cadastrarSapato:(context)=> WidgetCadastroSapato(),
        Rotas.detalhesSapatos:(context)=> WidgetDetalhesSapatos(sapato: {}),
      }  
    );
  }
}