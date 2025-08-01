import 'package:projeto_lary/banco/dao/acessorioDAO.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/services/acessorio_firebase_service.dart';

class AcessorioRepository {
  final _localDAO = AcessorioDAO();
  final _firebaseService = AcessorioFirebaseService();

  Future<void> salvar(DTOAcessorios acessorio) async {
    final id = await _firebaseService.salvar(acessorio);
    acessorio.id = id;
    await _localDAO.salvar(acessorio);
  }

  Future<void> excluir(DTOAcessorios acessorio) async {
    if (acessorio.id != null) {
      await _firebaseService.excluir(acessorio.id!);
      await _localDAO.excluir(acessorio.id!);
    }
  }

  Future<List<DTOAcessorios>> listar() async {
    try {
      final acessoriosRemotos = await _firebaseService.listar();
      final acessoriosLocais = await _localDAO.listar();

      final Map<String, DTOAcessorios> mapaUnificado = {};
      for (var acessorio in acessoriosLocais) {
        if (acessorio.id != null) mapaUnificado[acessorio.id!] = acessorio;
      }
      for (var acessorio in acessoriosRemotos) {
         if (acessorio.id != null) mapaUnificado[acessorio.id!] = acessorio;
      }

      final listaFinal = mapaUnificado.values.toList();
      listaFinal.sort((a, b) => (a.modelo ?? '').compareTo(b.modelo ?? ''));
      
      await _localDAO.sincronizar(listaFinal);

      return listaFinal;
    } catch (e) {
      print('Falha ao conectar ao Firebase, retornando dados locais: $e');
      return await _localDAO.listar();
    }
  }
}
