import 'package:projeto_lary/banco/Conexao.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:sqflite/sqflite.dart';

class AcessorioDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Future<void> salvar(DTOAcessorios acessorio) async {
    var database = await db;
    await database.insert(
      'acessorio', 
      acessorio.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

Future<DTOAcessorios?> buscarPorId(String id) async { 
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query(
      'acessorio',
      where: 'id = ?',
      whereArgs: [id], 
    );

    if (maps.isNotEmpty) {
      return DTOAcessorios.fromMap(maps.first);
    }
    return null;
  }

  Future<void> excluir(String id) async {
    var database = await db;
    await database.delete('acessorio', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOAcessorios>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('acessorio', orderBy: 'modelo');
    return List.generate(maps.length, (i) => DTOAcessorios.fromMap(maps[i]));
  }

  Future<void> sincronizar(List<DTOAcessorios> acessorios) async {
    var database = await db;
    var batch = database.batch();
    batch.delete('acessorio');
    for (var acessorio in acessorios) {
      batch.insert('acessorio', acessorio.toMap());
    }
    await batch.commit(noResult: true);
  }
}
