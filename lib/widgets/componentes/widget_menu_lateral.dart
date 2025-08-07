import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOUsuario.dart';
import 'package:projeto_lary/configuracao/rotas.dart';

/// Um widget reutilizável que representa o menu lateral (Drawer) do aplicativo.
class WidgetMenuLateral extends StatefulWidget {
  final DTOUsuario usuario;

  const WidgetMenuLateral({super.key, required this.usuario});

  @override
  State<WidgetMenuLateral> createState() => _WidgetMenuLateralState();
}

class _WidgetMenuLateralState extends State<WidgetMenuLateral> {
  late DTOUsuario _usuarioAtual;

  @override
  void initState() {
    super.initState();
    _usuarioAtual = widget.usuario;
  }

  /// Função auxiliar para criar os itens do menu de forma consistente.
  Widget _criarItemMenu({
    required IconData icone,
    required String rotulo,
    required VoidCallback aoPressionar,
  }) {
    return ListTile(
      leading: Icon(icone, color: const Color.fromARGB(255, 243, 33, 219)),
      title: Text(rotulo, style: const TextStyle(fontSize: 16)),
      onTap: () {
        // Fecha o menu lateral antes de navegar para a nova tela.
        Navigator.pop(context);
        aoPressionar();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // O Drawer é o widget que cria o menu lateral.
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // O cabeçalho do menu que mostra os dados do usuário.
          UserAccountsDrawerHeader(
            accountName: Text(
              _usuarioAtual.nome ?? 'Usuário',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(_usuarioAtual.email ?? ''),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, Rotas.usuario, arguments: _usuarioAtual);
              },
              child: CircleAvatar(
                backgroundImage: (_usuarioAtual.fotoPerfil != null && _usuarioAtual.fotoPerfil!.isNotEmpty)
                    ? NetworkImage(_usuarioAtual.fotoPerfil!)
                    : null,
                backgroundColor: Colors.white,
                child: (_usuarioAtual.fotoPerfil == null || _usuarioAtual.fotoPerfil!.isEmpty)
                    ? Text(
                        _usuarioAtual.nome?.substring(0, 1).toUpperCase() ?? 'U',
                        style: const TextStyle(fontSize: 40.0, color: Color.fromARGB(255, 243, 33, 219)),
                      )
                    : null,
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 243, 33, 219),
            ),
          ),
          
          _criarItemMenu(
            icone: Icons.home,
            rotulo: 'Início',
            aoPressionar: () {
                if (ModalRoute.of(context)?.settings.name != Rotas.menu) {
                    Navigator.pushNamedAndRemoveUntil(context, Rotas.menu, (route) => false, arguments: _usuarioAtual);
                }
            },
          ),
          const Divider(),
          
          _criarItemMenu(
            icone: Icons.checkroom,
            rotulo: 'Minhas Roupas',
            aoPressionar: () => Navigator.pushNamed(context, Rotas.roupas, arguments: _usuarioAtual),
          ),
          _criarItemMenu(
            icone: Icons.ice_skating,
            rotulo: 'Meus Sapatos',
            aoPressionar: () => Navigator.pushNamed(context, Rotas.sapatos, arguments: _usuarioAtual),
          ),
          _criarItemMenu(
            icone: Icons.watch,
            rotulo: 'Meus Acessórios',
            aoPressionar: () => Navigator.pushNamed(context, Rotas.acessorios, arguments: _usuarioAtual),
          ),
          _criarItemMenu(
            icone: Icons.style,
            rotulo: 'Meus Looks',
            aoPressionar: () => Navigator.pushNamed(context, Rotas.looks, arguments: _usuarioAtual),
          ),
          _criarItemMenu(
            icone: Icons.event,
            rotulo: 'Meus Eventos',
            aoPressionar: () => Navigator.pushNamed(context, Rotas.eventos, arguments: _usuarioAtual),
          ),
           _criarItemMenu(
            icone: Icons.luggage,
            rotulo: 'Minhas Malas',
            aoPressionar: () => Navigator.pushNamed(context, Rotas.malas, arguments: _usuarioAtual),
          ),
          const Divider(),
          _criarItemMenu(
            icone: Icons.person,
            rotulo: 'Editar Perfil',
            aoPressionar: () async {
              final usuarioAtualizado = await Navigator.pushNamed(context, Rotas.editarPerfil, arguments: _usuarioAtual);
              if (usuarioAtualizado is DTOUsuario) {
                setState(() => _usuarioAtual = usuarioAtualizado);
              }
            },
          ),
          _criarItemMenu(
            icone: Icons.logout,
            rotulo: 'Sair',
            aoPressionar: () {
              Navigator.pushNamedAndRemoveUntil(context, Rotas.login, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
