import 'package:projeto_lary/banco/conexao.dart';
import 'package:projeto_lary/banco/dao/acessorioDAO.dart';
import 'package:projeto_lary/banco/dao/roupaDAO.dart';
import 'package:projeto_lary/banco/dao/sapatoDAO.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:sqflite/sqflite.dart';

class LookDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Future<void> salvar(DTOLook look) async {
    var database = await db;
    var batch = database.batch();

    batch.insert('look', {'id': look.id, 'nome': look.nome},
        conflictAlgorithm: ConflictAlgorithm.replace);

    batch.delete('look_item', where: 'id_look = ?', whereArgs: [look.id]);

    for (var item in look.roupas) {
      batch.insert('look_item', {'id_look': look.id, 'id_item': item.id, 'tipo_item': 'roupa'});
    }
    for (var item in look.sapatos) {
      batch.insert('look_item', {'id_look': look.id, 'id_item': item.id, 'tipo_item': 'sapato'});
    }
    for (var item in look.acessorios) {
      batch.insert('look_item', {'id_look': look.id, 'id_item': item.id, 'tipo_item': 'acessorio'});
    }
    
    await batch.commit(noResult: true);
  }

  Future<void> excluir(String id) async {
    var database = await db;
    await database.delete('look_item', where: 'id_look = ?', whereArgs: [id]);
    await database.delete('look', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOLook>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('look');
    
    return Future.wait(maps.map((map) => _fromMap(map)).toList());
  }

  Future<DTOLook> _fromMap(Map<String, dynamic> map) async {
    var database = await db;
    String lookId = map['id'];

    final List<Map<String, dynamic>> itemMaps = await database.query('look_item', where: 'id_look = ?', whereArgs: [lookId]);

    final roupaDAO = RoupaDAO();
    final sapatoDAO = SapatoDAO();
    final acessorioDAO = AcessorioDAO();

    final roupas = (await Future.wait(itemMaps.where((i) => i['tipo_item'] == 'roupa').map((i) => roupaDAO.buscarPorId(i['id_item'])))).whereType<DTORoupas>().toList();
    final sapatos = (await Future.wait(itemMaps.where((i) => i['tipo_item'] == 'sapato').map((i) => sapatoDAO.buscarPorId(i['id_item'])))).whereType<DTOSapato>().toList();
    final acessorios = (await Future.wait(itemMaps.where((i) => i['tipo_item'] == 'acessorio').map((i) => acessorioDAO.buscarPorId(i['id_item'])))).whereType<DTOAcessorios>().toList();

    return DTOLook(
      id: lookId,
      nome: map['nome'],
      roupas: roupas,
      sapatos: sapatos,
      acessorios: acessorios,
    );
  }

  Future<void> sincronizar(List<DTOLook> looks) async {
    var database = await db;
    var batch = database.batch();
    batch.delete('look_item');
    batch.delete('look');
    for (var look in looks) {
      batch.insert('look', {'id': look.id, 'nome': look.nome});
      for (var item in look.roupas) batch.insert('look_item', {'id_look': look.id, 'id_item': item.id, 'tipo_item': 'roupa'});
      for (var item in look.sapatos) batch.insert('look_item', {'id_look': look.id, 'id_item': item.id, 'tipo_item': 'sapato'});
      for (var item in look.acessorios) batch.insert('look_item', {'id_look': look.id, 'id_item': item.id, 'tipo_item': 'acessorio'});
    }
    await batch.commit(noResult: true);
  }
}
