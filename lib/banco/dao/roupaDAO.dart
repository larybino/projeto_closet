import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projeto_lary/banco/Conexao.dart';
class RoupaDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Map<String, dynamic> _toMap(DTORoupas roupa) {
    return {
      'id': roupa.id ,
      'modelo': roupa.modelo,
      'tipo': roupa.tipo,
      'cor': roupa.cor,
      'marca': roupa.marca,
      'url_foto': roupa.fotoUrl,
    };
  }

  DTORoupas _fromMap(Map<String, dynamic> map) {
    return DTORoupas.fromMap(map);
  }

  Future<DTORoupas?> buscarPorId(int id) async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query(
      'roupa',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return _fromMap(maps.first); 
    }
    return null;
  }

  Future<void> salvar(DTORoupas roupa) async {
    var database = await db;
    await database.insert(
      'roupa', 
      _toMap(roupa), 
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> excluir(int id) async {
    var database = await db;
    await database.delete('roupa', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTORoupas>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('roupa', orderBy: 'modelo');
    return List.generate(maps.length, (i) {
      return _fromMap(maps[i]);
    });
  }

   Future<void> sincronizar(List<DTORoupas> roupas) async {
    var database = await db;
    var batch = database.batch();
    batch.delete('roupa');
    for (var roupa in roupas) {
      batch.insert('roupa', _toMap(roupa));
    }
    await batch.commit(noResult: true);
  }
}
