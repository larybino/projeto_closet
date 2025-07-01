import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/configuracao/rotas.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/widgets/lists/widget_acessorios.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_acessorios.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_acessorios.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_evento.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_look.dart';
import 'package:projeto_lary/widgets/lists/widget_look.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_roupa.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_roupas.dart';
import 'package:projeto_lary/widgets/lists/widget_roupa.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_sapato.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_sapato.dart';
import 'package:projeto_lary/widgets/lists/widget_sapato.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_usuario.dart';
import 'package:projeto_lary/widgets/forms/widget_editar_perfil.dart';
import 'package:projeto_lary/widgets/forms/widget_login_usuario.dart';
import 'package:projeto_lary/widgets/lists/widget_usuario.dart';
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
        Rotas.look:(context)=> WidgetLook(),
        Rotas.detalhesRoupas:(context)=> WidgetDetalhesRoupas(roupa: DTORoupas()), // Replace with a valid DTORoupas object
        Rotas.cadastrarRoupa:(context)=> WidgetCadastroRoupa(),
        Rotas.cadastrarAcessorios:(context)=> WidgetCadastroAcessorios(),
        Rotas.cadastrarLook:(context)=> WidgetCadastroLook(),
        Rotas.cadastrarEvento:(context)=> WidgetCadastroEvento(),
        Rotas.detalhesEvento:(context)=> WidgetCadastroEvento(),
        Rotas.detalhesLook:(context)=> WidgetCadastroLook(),
        Rotas.detalhesAcessorios:(context)=> WidgetDetalhesAcessorios(acessorios: DTOAcessorios()), // Replace with a valid DTOAcessorios object
        Rotas.cadastrarSapato:(context)=> WidgetCadastroSapato(),
        Rotas.detalhesSapatos:(context)=> WidgetDetalhesSapatos(sapato: DTOSapato()), // Replace with a valid DTOSapato object
      }  
    );
  }
}