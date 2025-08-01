import 'package:projeto_lary/banco/dto/DTOUsuario.dart';
import 'package:projeto_lary/services/usuario_firebase_service.dart';

class UsuarioRepository {
  final _firebaseService = UsuarioFirebaseService();
  // final _localDAO = UsuarioDAO();

  Future<void> salvar(DTOUsuario usuario) async {
    await _firebaseService.salvarPerfil(usuario);
    // await _localDAO.salvar(usuario);
  }

  Future<DTOUsuario?> buscarPorId(String id) async {
    // Tenta buscar no Firebase, se falhar, busca no cache local
    try {
      return await _firebaseService.buscarPerfil(id);
    } catch (e) {
      // return await _localDAO.buscarPorId(id);
      return null;
    }
  }
}