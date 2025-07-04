import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:projeto_lary/banco/dto/DTOUsuario.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_acessorios.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_evento.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_look.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_roupa.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_sapato.dart';
import 'package:projeto_lary/widgets/forms/widget_cadastro_usuario.dart';
import 'package:projeto_lary/widgets/forms/widget_editar_perfil.dart';
import 'package:projeto_lary/widgets/forms/widget_login_usuario.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_look.dart';
import 'package:projeto_lary/widgets/lists/widget_acessorios.dart';
import 'package:projeto_lary/widgets/lists/widget_evento.dart';
import 'package:projeto_lary/widgets/lists/widget_look.dart';
import 'package:projeto_lary/widgets/lists/widget_roupa.dart';
import 'package:projeto_lary/widgets/lists/widget_sapato.dart';
import 'package:projeto_lary/widgets/lists/widget_usuario.dart';
import 'package:projeto_lary/widgets/widget_menu.dart';
import 'package:projeto_lary/widgets/widget_telaInicial.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_acessorios.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_roupas.dart';
import 'package:projeto_lary/widgets/lists/detalhes/widget_detalhes_sapato.dart';


class Rotas {
  static const String home = '/';
  static const String login = '/login';
  static const String menu = '/menu';
  static const String cadastro = '/cadastro';
  static const String usuario = '/usuario';
  static const String editarPerfil = '/editar-perfil';
  
  static const String roupas = '/roupas';
  static const String cadastrarRoupa = '/cadastrar-roupa';
  static const String detalhesRoupas = '/detalhes-roupa';

  static const String sapatos = '/sapatos';
  static const String cadastrarSapato = '/cadastrar-sapato';
  static const String detalhesSapatos = '/detalhes-sapato';

  static const String acessorios = '/acessorios';
  static const String cadastrarAcessorios = '/cadastrar-acessorio';
  static const String detalhesAcessorios = '/detalhes-acessorio';

  static const String looks = '/looks';
  static const String cadastrarLook = '/cadastrar-look';
  static const String detalhesLooks = '/detalhes-look';
  
  static const String eventos = '/eventos';
  static const String cadastrarEvento = '/cadastrar-evento';

  static Route<dynamic> gerarRota(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const WidgetTelaInicial());
      case login:
        return MaterialPageRoute(builder: (_) => const WidgetLoginUsuario());
      case cadastro:
        return MaterialPageRoute(builder: (_) => const WidgetCadastroUsuario());

      case menu:
        if (args is DTOUsuario) {
          return MaterialPageRoute(builder: (_) => WidgetMenu(usuario: args));
        }
        return _erroRota(mensagem: 'Usuário não fornecido para o menu.');


      case usuario:
          if (args is DTOUsuario) {
              return MaterialPageRoute(builder: (_) => WidgetUsuario(usuario: args));
          }
        return _erroRota(mensagem: 'Usuário não fornecido para a tela de perfil.');
      case editarPerfil:
        if (args is DTOUsuario) {
          return MaterialPageRoute(builder: (_) => WidgetEditarPerfil(usuario: args));
        }
        return _erroRota(mensagem: 'Usuário não fornecido para editar perfil.');

      case roupas:
        return MaterialPageRoute(builder: (_) => const WidgetRoupa());
      case cadastrarRoupa:
        final roupa = args is DTORoupas ? args : null;
        return MaterialPageRoute(builder: (_) => WidgetCadastroRoupa(roupa: roupa));
      case detalhesRoupas:
        if (args is DTORoupas) {
          return MaterialPageRoute(builder: (_) => WidgetDetalhesRoupas(roupa: args));
        }
        return _erroRota();

      case sapatos:
        return MaterialPageRoute(builder: (_) => const WidgetSapato());
      case cadastrarSapato:
        final sapato = args is DTOSapato ? args : null;
        return MaterialPageRoute(builder: (_) => WidgetCadastroSapato(sapato: sapato));
      case detalhesSapatos:
        if (args is DTOSapato) {
          return MaterialPageRoute(builder: (_) => WidgetDetalhesSapatos(sapato: args));
        }
        return _erroRota();

      case acessorios:
        return MaterialPageRoute(builder: (_) => const WidgetAcessorios());
      case cadastrarAcessorios:
        final acessorio = args is DTOAcessorios ? args : null;
        return MaterialPageRoute(builder: (_) => WidgetCadastroAcessorios(acessorio: acessorio));
      case detalhesAcessorios:
        if (args is DTOAcessorios) {
          return MaterialPageRoute(builder: (_) => WidgetDetalhesAcessorios(acessorio: args));
        }
        return _erroRota();

      case looks:
        return MaterialPageRoute(builder: (_) =>  WidgetLook());
      case cadastrarLook:
        final look = args is DTOLook ? args : null;
        return MaterialPageRoute(builder: (_) => WidgetCadastroLook(look: look));
      case detalhesLooks:
        if (args is DTOLook) {
          return MaterialPageRoute(builder: (_) => WidgetDetalhesLook(look: args));
        }
        return _erroRota();
      
      case cadastrarEvento:
        return MaterialPageRoute(builder: (_) => const WidgetCadastroEvento());
      case eventos:
        return MaterialPageRoute(builder: (_) => const WidgetEventos());
      default:
        return _erroRota(mensagem: 'Rota ${settings.name} não encontrada.');
    
    
    
    }
  }

  static Route<dynamic> _erroRota({String mensagem = 'Página não encontrada'}) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Erro')),
        body: Center(child: Text(mensagem)),
      );
    });
  }
}
