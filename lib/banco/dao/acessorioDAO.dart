import 'package:projeto_lary/banco/Conexao.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:sqflite/sqflite.dart';

class AcessorioDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Map<String, dynamic> _toMap(DTOAcessorios acessorio) {
    return {
      'id': acessorio.id != null ? int.tryParse(acessorio.id!) : null,
      'modelo': acessorio.modelo,
      'tipo': acessorio.tipo,
      'cor': acessorio.cor,
      'marca': acessorio.marca,
      'url_foto': acessorio.fotoUrl,
    };
  }

  DTOAcessorios _fromMap(Map<String, dynamic> map) {
    return DTOAcessorios(
      id: map['id']?.toString(),
      modelo: map['modelo'],
      tipo: map['tipo'],
      cor: map['cor'],
      marca: map['marca'],
      fotoUrl: map['url_foto'],
    );
  }

  Future<int> salvar(DTOAcessorios acessorio) async {
    var database = await db;
    Map<String, dynamic> acessorioMap = _toMap(acessorio);

    if (acessorio.id == null) {
      acessorioMap.remove('id');
      return await database.insert('acessorio', acessorioMap);
    } else {
      return await database.update('acessorio', acessorioMap, where: 'id = ?', whereArgs: [acessorio.id]);
    }
  }

  Future<DTOAcessorios?> buscarPorId(int id) async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query(
      'acessorio',
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
    return await database.delete('acessorio', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOAcessorios>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('acessorio', orderBy: 'modelo');
    return List.generate(maps.length, (i) {
      return _fromMap(maps[i]);
    });
  }
}
