import 'package:projeto_lary/banco/Conexao.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:sqflite/sqflite.dart';

class SapatoDAO {
  Future<Database> get db => ConexaoSQLite.database;



 Future<void> salvar(DTOSapato sapato) async {
    var database = await db;
    await database.insert(
      'sapato', 
      sapato.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

Future<DTOSapato?> buscarPorId(String id) async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query(
      'sapato',
      where: 'id = ?',
      whereArgs: [id], 
    );

    if (maps.isNotEmpty) {
      return DTOSapato.fromMap(maps.first);
    }
    return null;
  }

Future<void> excluir(String id) async {
    var database = await db;
    await database.delete('sapato', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOSapato>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('sapato', orderBy: 'modelo');
    return List.generate(maps.length, (i) => DTOSapato.fromMap(maps[i]));
  }

  Future<void> sincronizar(List<DTOSapato> sapatos) async {
    var database = await db;
    var batch = database.batch();
    batch.delete('sapato');
    for (var sapato in sapatos) {
      batch.insert('sapato', sapato.toMap());
    }
    await batch.commit(noResult: true);
  }
}
