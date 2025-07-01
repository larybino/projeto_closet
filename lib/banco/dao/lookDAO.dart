import 'package:projeto_lary/banco/Conexao.dart';
import 'package:projeto_lary/banco/dao/RoupaDAO.dart';
import 'package:projeto_lary/banco/dao/acessorioDAO.dart';
import 'package:projeto_lary/banco/dao/sapatoDAO.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:sqflite/sqflite.dart';


class LookDAO {
  Future<Database> get db => ConexaoSQLite.database;

  Future<int> salvar(DTOLook look) async {
    var database = await db;
    int lookId = 0;

    await database.transaction((txn) async {
      Map<String, dynamic> lookMap = {
        'nome': look.nome,
      };

      if (look.id == null) {
        lookId = await txn.insert('look', lookMap);
      } else {
        await txn.update('look', lookMap, where: 'id = ?', whereArgs: [look.id]);
        lookId = look.id!;
        await txn.delete('look_item', where: 'id_look = ?', whereArgs: [lookId]);
      }
      
      for (var roupa in look.roupas) {
        await txn.insert('look_item', {
          'id_look': lookId,
          'id_item': int.tryParse(roupa.id ?? '0'),
          'tipo_item': 'roupa',
        });
      }

      for (var sapato in look.sapatos) {
        await txn.insert('look_item', {
          'id_look': lookId,
          'id_item': int.tryParse(sapato.id ?? '0'),
          'tipo_item': 'sapato',
        });
      }

      for (var acessorio in look.acessorios) {
        await txn.insert('look_item', {
          'id_look': lookId,
          'id_item': int.tryParse(acessorio.id ?? '0'),
          'tipo_item': 'acessorio',
        });
      }
    });

    return lookId;
  }

  Future<int> excluir(int id) async {
    var database = await db;
    await database.delete('look_item', where: 'id_look = ?', whereArgs: [id]);
    return await database.delete('look', where: 'id = ?', whereArgs: [id]);
  }

  Future<DTOLook?> buscarPorId(int id) async {
      var database = await db;
      final List<Map<String, dynamic>> maps = await database.query(
        'look',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return await _fromMap(maps.first);
      }
      return null;
  }

  Future<List<DTOLook>> listar() async {
    var database = await db;
    final List<Map<String, dynamic>> maps = await database.query('look', orderBy: 'nome');
    
    List<DTOLook> looks = [];
    for (var map in maps) {
        looks.add(await _fromMap(map));
    }
    return looks;
  }

  Future<DTOLook> _fromMap(Map<String, dynamic> map) async {
    var database = await db;
    int lookId = map['id'];

    final List<Map<String, dynamic>> itemMaps = await database.query(
      'look_item',
      where: 'id_look = ?',
      whereArgs: [lookId],
    );

    List<DTORoupas> roupas = [];
    List<DTOSapato> sapatos = [];
    List<DTOAcessorios> acessorios = [];

    final roupaDAO = RoupaDAO();
    final sapatoDAO = SapatoDAO();
    final acessorioDAO = AcessorioDAO();


    
    for (var itemMap in itemMaps) {
      int itemId = itemMap['id_item'];
      String tipoItem = itemMap['tipo_item'];

      if (tipoItem == 'roupa') {
        var allRoupas = await roupaDAO.listar();
        var foundRoupa = allRoupas.where((r) => r.id == itemId.toString()).firstOrNull;
        if (foundRoupa != null) roupas.add(foundRoupa);

      } else if (tipoItem == 'sapato') {
        var allSapatos = await sapatoDAO.listar();
        var foundSapato = allSapatos.where((s) => s.id == itemId.toString()).firstOrNull;
        if (foundSapato != null) sapatos.add(foundSapato);

      } else if (tipoItem == 'acessorio') {
        var allAcessorios = await acessorioDAO.listar();
        var foundAcessorio = allAcessorios.where((a) => a.id == itemId.toString()).firstOrNull;
        if (foundAcessorio != null) acessorios.add(foundAcessorio);
      }
    }

    return DTOLook(
      id: lookId,
      nome: map['nome'],
      roupas: roupas,
      sapatos: sapatos,
      acessorios: acessorios,
    );
  }
}
