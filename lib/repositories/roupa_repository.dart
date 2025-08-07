import 'package:projeto_lary/banco/dao/roupaDAO.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/services/roupa_firebase_service.dart';

class RoupaRepository {
  final _localDAO = RoupaDAO();
  final _firebaseService = RoupaFirebaseService();

  Future<void> salvar(DTORoupas roupa) async {
    final id = await _firebaseService.salvar(roupa);
    roupa.id = id;
    
    await _localDAO.salvar(roupa);
  }

  Future<void> excluir(DTORoupas roupa) async {
    if (roupa.id != null) {
      await _firebaseService.excluir(roupa.id!);
      await _localDAO.excluir(int.parse(roupa.id!));
    }
  }

  Future<List<DTORoupas>> listar() async {
    try {
      final futureRemoto = _firebaseService.listar();
      final futureLocal = _localDAO.listar();
      
      final roupasRemotas = await futureRemoto;
      final roupasLocais = await futureLocal;

      final Map<String, DTORoupas> mapaUnificado = {};

      for (var roupa in roupasLocais) {
        if (roupa.id != null) {
          mapaUnificado[roupa.id!] = roupa;
        }
      }

      for (var roupa in roupasRemotas) {
         if (roupa.id != null) {
          mapaUnificado[roupa.id!] = roupa;
        }
      }

      final listaFinal = mapaUnificado.values.toList();
      listaFinal.sort((a, b) => (a.modelo ?? '').compareTo(b.modelo ?? ''));

      _localDAO.sincronizar(listaFinal);

      return listaFinal;

    } catch (e) {
      print('Falha ao conectar ao Firebase, retornando dados locais: $e');
      return await _localDAO.listar();
    }
  }
}
