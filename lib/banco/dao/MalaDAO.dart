import 'package:projeto_lary/banco/conexao.dart';
import 'package:projeto_lary/banco/dao/acessorioDAO.dart';
import 'package:projeto_lary/banco/dao/eventoDAO.dart';
import 'package:projeto_lary/banco/dao/roupaDAO.dart';
import 'package:projeto_lary/banco/dao/sapatoDAO.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOMala.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:sqflite/sqflite.dart';

class MalaDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Future<void> salvar(DTOMala mala) async {
    var database = await db;
    var batch = database.batch();

    batch.insert('mala', {'id': mala.id, 'nome': mala.nome, 'id_evento': mala.evento?.id},
        conflictAlgorithm: ConflictAlgorithm.replace);

    batch.delete('mala_item', where: 'id_mala = ?', whereArgs: [mala.id]);

    for (var item in mala.roupas) {
      batch.insert('mala_item', {'id_mala': mala.id, 'id_item': item.id, 'tipo_item': 'roupa'});
    }
    for (var item in mala.sapatos) {
      batch.insert('mala_item', {'id_mala': mala.id, 'id_item': item.id, 'tipo_item': 'sapato'});
    }
    for (var item in mala.acessorios) {
      batch.insert('mala_item', {'id_mala': mala.id, 'id_item': item.id, 'tipo_item': 'acessorio'});
    }
    
    await batch.commit(noResult: true);
  }

  Future<void> excluir(String id) async {
    var database = await db;
    await database.delete('mala_item', where: 'id_mala = ?', whereArgs: [id]);
    await database.delete('mala', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOMala>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('mala');
    
    return Future.wait(maps.map((map) => _fromMap(map)).toList());
  }

  Future<DTOMala?> buscarPorId(String id) async {
    var database = await db;
    final maps = await database.query('mala', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return await _fromMap(maps.first);
    }
    return null;
  }

  Future<DTOMala> _fromMap(Map<String, dynamic> map) async {
    var database = await db;
    String malaId = map['id'];

    final evento = map['id_evento'] != null ? await EventoDAO().buscarPorId(map['id_evento']) : null;
    final List<Map<String, dynamic>> itemMaps = await database.query('mala_item', where: 'id_mala = ?', whereArgs: [malaId]);

    final roupas = (await Future.wait(itemMaps.where((i) => i['tipo_item'] == 'roupa').map((i) => RoupaDAO().buscarPorId(i['id_item'])))).whereType<DTORoupas>().toList();
    final sapatos = (await Future.wait(itemMaps.where((i) => i['tipo_item'] == 'sapato').map((i) => SapatoDAO().buscarPorId(i['id_item'])))).whereType<DTOSapato>().toList();
    final acessorios = (await Future.wait(itemMaps.where((i) => i['tipo_item'] == 'acessorio').map((i) => AcessorioDAO().buscarPorId(i['id_item'])))).whereType<DTOAcessorios>().toList();

    return DTOMala(
      id: malaId,
      nome: map['nome'],
      evento: evento,
      roupas: roupas,
      sapatos: sapatos,
      acessorios: acessorios,
    );
  }

  Future<void> sincronizar(List<DTOMala> malas) async {
    var database = await db;
    var batch = database.batch();
    batch.delete('mala_item');
    batch.delete('mala');
    for (var mala in malas) {
      batch.insert('mala', {'id': mala.id, 'nome': mala.nome, 'id_evento': mala.evento?.id});
      for (var item in mala.roupas) batch.insert('mala_item', {'id_mala': mala.id, 'id_item': item.id, 'tipo_item': 'roupa'});
      for (var item in mala.sapatos) batch.insert('mala_item', {'id_mala': mala.id, 'id_item': item.id, 'tipo_item': 'sapato'});
      for (var item in mala.acessorios) batch.insert('mala_item', {'id_mala': mala.id, 'id_item': item.id, 'tipo_item': 'acessorio'});
    }
    await batch.commit(noResult: true);
  }
}
