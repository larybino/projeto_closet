import 'package:projeto_lary/banco/dao/lookDAO.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/services/look_firebase_service.dart';

class LookRepository {
  final _localDAO = LookDAO();
  final _firebaseService = LookFirebaseService();

  Future<void> salvar(DTOLook look) async {
    final id = await _firebaseService.salvar(look);
    look.id = id;
    await _localDAO.salvar(look);
  }

  Future<void> excluir(DTOLook look) async {
    if (look.id != null) {
      await _firebaseService.excluir(look.id!);
      await _localDAO.excluir(look.id!);
    }
  }

  Future<List<DTOLook>> listar() async {
    try {
      final looksRemotos = await _firebaseService.listar();
      await _localDAO.sincronizar(looksRemotos);
      return looksRemotos;
    } catch (e) {
      print('Falha ao conectar ao Firebase, retornando dados locais: $e');
      return await _localDAO.listar();
    }
  }
}