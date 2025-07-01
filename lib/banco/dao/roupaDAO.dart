import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:sqflite/sqflite.dart';
import 'package:projeto_lary/banco/Conexao.dart';
class RoupaDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Map<String, dynamic> _toMap(DTORoupas roupa) {
    return {
      'id': roupa.id,
      'modelo': roupa.modelo,
      'tipo': roupa.tipo,
      'cor': roupa.cor,
      'marca': roupa.marca,
      'url_foto': roupa.fotoUrl,
    };
  }

  DTORoupas _fromMap(Map<String, dynamic> map) {
    return DTORoupas(
      id: map['id']?.toString(),
      modelo: map['modelo'],
      tipo: map['tipo'],
      cor: map['cor'],
      marca: map['marca'],
      fotoUrl: map['url_foto'],
    );
  }

  Future<int> salvar(DTORoupas roupa) async {
    var database = await db;
    Map<String, dynamic> roupaMap = _toMap(roupa);

    if (roupa.id == null) {
      roupaMap.remove('id');
      return await database.insert('roupa', roupaMap);
    } else {
      return await database.update('roupa', roupaMap, where: 'id = ?', whereArgs: [roupa.id]);
    }
  }

  Future<int> excluir(int id) async {
    var database = await db;
    return await database.delete('roupa', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTORoupas>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('roupa', orderBy: 'modelo');
    return List.generate(maps.length, (i) {
      return _fromMap(maps[i]);
    });
  }
}
