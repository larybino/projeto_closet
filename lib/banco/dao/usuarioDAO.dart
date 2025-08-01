import 'package:projeto_lary/banco/dto/DTOUsuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projeto_lary/banco/Conexao.dart';

class UsuarioDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Future<void> salvar(DTOUsuario usuario) async {
    var database = await db;
    await database.insert(
      'usuario',
      usuario.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<DTOUsuario?> buscarPorId(String id) async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query(
      'usuario',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return DTOUsuario.fromMap(maps.first);
    }
    return null;
  }
}
