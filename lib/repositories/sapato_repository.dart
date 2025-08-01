import 'package:projeto_lary/banco/dao/sapatoDAO.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:projeto_lary/services/sapato_firebase_service.dart';

class SapatoRepository {
  final _localDAO = SapatoDAO();
  final _firebaseService = SapatoFirebaseService();

  Future<void> salvar(DTOSapato sapato) async {
    final id = await _firebaseService.salvar(sapato);
    sapato.id = id;
    await _localDAO.salvar(sapato);
  }

  Future<void> excluir(DTOSapato sapato) async {
    if (sapato.id != null) {
      await _firebaseService.excluir(sapato.id!);
      await _localDAO.excluir(sapato.id!);
    }
  }

  Future<List<DTOSapato>> listar() async {
    try {
      final sapatosRemotos = await _firebaseService.listar();
      final sapatosLocais = await _localDAO.listar();

      final Map<String, DTOSapato> mapaUnificado = {};
      for (var sapato in sapatosLocais) {
        if (sapato.id != null) mapaUnificado[sapato.id!] = sapato;
      }
      for (var sapato in sapatosRemotos) {
         if (sapato.id != null) mapaUnificado[sapato.id!] = sapato;
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
