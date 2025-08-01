import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_lary/banco/dto/DTOUsuario.dart';

class UsuarioFirebaseService {
  final CollectionReference _usuariosCollection = FirebaseFirestore.instance.collection('usuarios');

  Future<void> salvarPerfil(DTOUsuario usuario) async {
    if (usuario.id == null) throw Exception("ID do usuário não pode ser nulo");
    await _usuariosCollection.doc(usuario.id).set(usuario.toJson());
  }

  Future<DTOUsuario?> buscarPerfil(String id) async {
    DocumentSnapshot doc = await _usuariosCollection.doc(id).get();
    if (doc.exists) {
      return DTOUsuario.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }
}