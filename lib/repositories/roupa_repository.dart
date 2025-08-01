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
      // 1. Busca dados remotos e locais em paralelo para mais rapidez.
      final futureRemoto = _firebaseService.listar();
      final futureLocal = _localDAO.listar();
      
      final roupasRemotas = await futureRemoto;
      final roupasLocais = await futureLocal;

      // 2. Cria um mapa para fazer a união inteligente dos dados.
      final Map<String, DTORoupas> mapaUnificado = {};

      // Adiciona primeiro os dados locais. Se um item novo foi acabado de salvar,
      // ele estará aqui e será adicionado ao mapa.
      for (var roupa in roupasLocais) {
        if (roupa.id != null) {
          mapaUnificado[roupa.id!] = roupa;
        }
      }

      // Adiciona os dados remotos. Se um item já existir no mapa,
      // ele será substituído pela versão da nuvem, que é a "fonte da verdade".
      for (var roupa in roupasRemotas) {
         if (roupa.id != null) {
          mapaUnificado[roupa.id!] = roupa;
        }
      }

      // 3. Converte o mapa de volta para uma lista e ordena.
      final listaFinal = mapaUnificado.values.toList();
      listaFinal.sort((a, b) => (a.modelo ?? '').compareTo(b.modelo ?? ''));

      // 4. Sincroniza a lista final de volta para o banco local em segundo plano.
      //    Não precisamos de esperar (await) por isto para a UI ser rápida.
      _localDAO.sincronizar(listaFinal);

      return listaFinal;

    } catch (e) {
      // 5. Se tudo falhar (sem internet), retorna apenas os dados locais.
      print('Falha ao conectar ao Firebase, retornando dados locais: $e');
      return await _localDAO.listar();
    }
  }
}
