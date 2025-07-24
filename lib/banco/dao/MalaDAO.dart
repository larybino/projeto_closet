
import 'package:projeto_lary/banco/conexao.dart';
import 'package:projeto_lary/banco/dao/acessorioDAO.dart';
import 'package:projeto_lary/banco/dao/eventoDAO.dart';
import 'package:projeto_lary/banco/dao/roupaDAO.dart';
import 'package:projeto_lary/banco/dao/sapatoDAO.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOMala.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MalaDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Future<int> salvar(DTOMala mala) async {
    var database = await db;
    int malaId = 0;

    await database.transaction((txn) async {
      Map<String, dynamic> malaMap = {
        'nome': mala.nome,
        'id_evento': mala.evento?.id,
      };

      if (mala.id == null) {
        malaId = await txn.insert('mala', malaMap);
      } else {
        await txn.update('mala', malaMap, where: 'id = ?', whereArgs: [mala.id]);
        malaId = mala.id!;
        await txn.delete('mala_item', where: 'id_mala = ?', whereArgs: [malaId]);
      }

      for (var roupa in mala.roupas) {
        await txn.insert('mala_item', {'id_mala': malaId, 'id_item': roupa.id, 'tipo_item': 'roupa'});
      }
      for (var sapato in mala.sapatos) {
        await txn.insert('mala_item', {'id_mala': malaId, 'id_item': sapato.id, 'tipo_item': 'sapato'});
      }
      for (var acessorio in mala.acessorios) {
        await txn.insert('mala_item', {'id_mala': malaId, 'id_item': acessorio.id, 'tipo_item': 'acessorio'});
      }
    });
    return malaId;
  }

  Future<int> excluir(int id) async {
    var database = await db;
    await database.delete('mala_item', where: 'id_mala = ?', whereArgs: [id]);
    return await database.delete('mala', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DTOMala>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('mala', orderBy: 'nome');
    
    List<DTOMala> malas = [];
    for (var map in maps) {
        malas.add(await _fromMap(map));
    }
    return malas;
  }

  Future<DTOMala> _fromMap(Map<String, dynamic> map) async {
    var database = await db;
    int malaId = map['id'];

    final evento = map['id_evento'] != null ? await EventoDAO().buscarPorId(map['id_evento']) : null;

    final List<Map<String, dynamic>> itemMaps = await database.query('mala_item', where: 'id_mala = ?', whereArgs: [malaId]);

    List<DTORoupas> roupas = [];
    List<DTOSapato> sapatos = [];
    List<DTOAcessorios> acessorios = [];

    for (var itemMap in itemMaps) {
      int itemId = itemMap['id_item'];
      String tipoItem = itemMap['tipo_item'];

      if (tipoItem == 'roupa') {
        var item = await RoupaDAO().buscarPorId(itemId);
        if (item != null) roupas.add(item);
      } else if (tipoItem == 'sapato') {
        var item = await SapatoDAO().buscarPorId(itemId);
        if (item != null) sapatos.add(item);
      } else if (tipoItem == 'acessorio') {
        var item = await AcessorioDAO().buscarPorId(itemId);
        if (item != null) acessorios.add(item);
      }
    }

    return DTOMala(
      id: malaId,
      nome: map['nome'],
      evento: evento,
      roupas: roupas,
      sapatos: sapatos,
      acessorios: acessorios,
    );
  }
}
