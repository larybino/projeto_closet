import 'package:projeto_lary/banco/Conexao.dart';
import 'package:projeto_lary/banco/dao/lookDAO.dart';
import 'package:projeto_lary/widgets/evento/DTOEvento.dart';
import 'package:projeto_lary/widgets/look/DTOLook.dart';
import 'package:sqflite/sqflite.dart';

class EventoDAO {
  Future<Database> get db => ConexaoSQLite.database;

 
  Map<String, dynamic> _toMap(DTOEvento evento) {
    return {
      'id': evento.id != null ? int.tryParse(evento.id!) : null,
      'nome': evento.nome,
      'data': evento.data,
      'id_look': evento.look?.id,
    };
  }

  Future<DTOEvento> _fromMap(Map<String, dynamic> map) async {
    DTOLook? look;
    final lookId = map['id_look'];

    if (lookId != null) {
      look = await LookDAO().buscarPorId(lookId);
    }

    return DTOEvento.fromMap(map, look: look);
  }

  Future<int> salvar(DTOEvento evento) async {
    var database = await db;
    Map<String, dynamic> eventoMap = _toMap(evento);

    if (evento.id == null) {
      eventoMap.remove('id');
      return await database.insert('evento', eventoMap);
    } else {
      return await database.update('evento', eventoMap, where: 'id = ?', whereArgs: [evento.id]);
    }
  }

  Future<int> excluir(int id) async {
    var database = await db;
    return await database.delete('evento', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOEvento>> listar() async {
    var database = await db;
    
    final List<Map<String, dynamic>> maps = await database.query(
      'evento',
      orderBy: 'data DESC', 
    );

    return Future.wait(maps.map((map) => _fromMap(map)).toList());
  }
  
  Future<DTOEvento?> buscarPorId(int id) async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query(
      'evento',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return await _fromMap(maps.first);
    }
    return null;
  }
}
