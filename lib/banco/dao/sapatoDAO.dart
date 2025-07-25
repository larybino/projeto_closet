import 'package:projeto_lary/banco/Conexao.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:sqflite/sqflite.dart';

class SapatoDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Map<String, dynamic> _toMap(DTOSapato sapato) {
    return {
      'id': sapato.id != null ? int.tryParse(sapato.id!) : null,
      'modelo': sapato.modelo,
      'tipo': sapato.tipo,
      'cor': sapato.cor,
      'marca': sapato.marca,
      'url_foto': sapato.fotoUrl,
    };
  }

  DTOSapato _fromMap(Map<String, dynamic> map) {
    return DTOSapato(
      id: map['id']?.toString(),
      modelo: map['modelo'],
      tipo: map['tipo'],
      cor: map['cor'],
      marca: map['marca'],
      fotoUrl: map['url_foto'],
    );
  }

  Future<int> salvar(DTOSapato sapato) async {
    var database = await db;
    Map<String, dynamic> sapatoMap = _toMap(sapato);

    if (sapato.id == null) {
      sapatoMap.remove('id');
      return await database.insert('sapato', sapatoMap);
    } else {
      return await database.update('sapato', sapatoMap, where: 'id = ?', whereArgs: [sapato.id]);
    }
  }

   Future<DTOSapato?> buscarPorId(int id) async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query(
      'sapato',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return _fromMap(maps.first);
    }
    return null;
  }

  Future<int> excluir(int id) async {
    var database = await db;
    return await database.delete('sapato', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOSapato>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('sapato', orderBy: 'modelo');
    return List.generate(maps.length, (i) {
      return _fromMap(maps[i]);
    });
  }
}
