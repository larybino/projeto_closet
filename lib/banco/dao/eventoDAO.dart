import 'package:projeto_lary/banco/conexao.dart';
import 'package:projeto_lary/banco/dao/lookDAO.dart';
import 'package:projeto_lary/banco/dto/DTOEvento.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:sqflite/sqflite.dart';

class EventoDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Future<void> salvar(DTOEvento evento) async {
    var database = await db;
    await database.insert(
      'evento',
      {'id': evento.id, 'nome': evento.nome, 'data': evento.data, 'id_look': evento.look?.id},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> excluir(String id) async { // CORREÇÃO: Parâmetro alterado para String
    var database = await db;
    await database.delete('evento', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOEvento>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('evento', orderBy: 'data DESC');
    
    return Future.wait(maps.map((map) => _fromMap(map)).toList());
  }

  Future<DTOEvento?> buscarPorId(String id) async {
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

  Future<DTOEvento> _fromMap(Map<String, dynamic> map) async {
    DTOLook? look;
    if (map['id_look'] != null) {
      look = await LookDAO().buscarPorId(map['id_look']);
    }
    return DTOEvento(
      id: map['id'],
      nome: map['nome'],
      data: map['data'],
      look: look,
    );
  }

  Future<void> sincronizar(List<DTOEvento> eventos) async {
    var database = await db;
    var batch = database.batch();
    
    batch.delete('evento');
    
    for (var evento in eventos) {
      batch.insert('evento', {'id': evento.id, 'nome': evento.nome, 'data': evento.data, 'id_look': evento.look?.id});
    }
    
    await batch.commit(noResult: true);
  }
}
