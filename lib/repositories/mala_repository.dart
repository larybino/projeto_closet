import 'package:projeto_lary/banco/dao/MalaDAO.dart';
import 'package:projeto_lary/banco/dto/DTOMala.dart';
import 'package:projeto_lary/services/mala_firebase_service.dart';

class MalaRepository {
  final _localDAO = MalaDAO();
  final _firebaseService = MalaFirebaseService();

  Future<void> salvar(DTOMala mala) async {
    final id = await _firebaseService.salvar(mala);
    mala.id = id;
    await _localDAO.salvar(mala);
  }

  Future<void> excluir(DTOMala mala) async {
    if (mala.id != null) {
      await _firebaseService.excluir(mala.id!);
      await _localDAO.excluir(mala.id!);
    }
  }

  Future<List<DTOMala>> listar() async {
    try {
      final malasRemotas = await _firebaseService.listar();
      await _localDAO.sincronizar(malasRemotas);
      return malasRemotas;
    } catch (e) {
      print('Falha ao conectar ao Firebase, retornando dados locais: $e');
      return await _localDAO.listar();
    }
  }

  Future<DTOMala?> buscarPorId(String id) async {
    try {
      return await _firebaseService.buscarPorId(id);
    } catch (e) {
      return await _localDAO.buscarPorId(id);
    }
  }
}
