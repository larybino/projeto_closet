import 'package:projeto_lary/banco/Conexao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projeto_lary/widgets/usuario/DTOUsuario.dart';


class UsuarioDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Map<String, dynamic> _toMap(DTOUsuario usuario) {
    return {
      'id': usuario.id,
      'nome': usuario.nome,
      'email': usuario.email,
      'senha': usuario.senha,
      'url_foto': usuario.fotoPerfil,
    };
  }

  DTOUsuario _fromMap(Map<String, dynamic> map) {
    return DTOUsuario(
      id: map['id']?.toString(),
      nome: map['nome'],
      email: map['email'],
      senha: map['senha'],
      fotoPerfil: map['url_foto'],
    );
  }

  Future<int> salvar(DTOUsuario usuario) async {
    var database = await db;
    Map<String, dynamic> usuarioMap = _toMap(usuario);

    if (usuario.id == null) {
      usuarioMap.remove('id');
      return await database.insert('usuario', usuarioMap);
    } else {
      return await database.update('usuario', usuarioMap, where: 'id = ?', whereArgs: [usuario.id]);
    }
  }

  Future<int> excluir(int id) async {
    var database = await db;
    return await database.delete('usuario', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOUsuario>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('usuario');
    return List.generate(maps.length, (i) {
      return _fromMap(maps[i]);
    });
  }

  Future<DTOUsuario?> buscarPorEmail(String email) async {
      var database = await db;
      final List<Map<String, dynamic>> maps = await database.query(
        'usuario',
        where: 'email = ?',
        whereArgs: [email],
      );

      if (maps.isNotEmpty) {
        return _fromMap(maps.first);
      }
      return null;
  }
}
