import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';

class AcessorioFirebaseService {
  final _auth = FirebaseAuth.instance;
  
  CollectionReference get _acessoriosCollection {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado.');
    return FirebaseFirestore.instance.collection('usuarios/${user.uid}/acessorios');
  }

  Future<String> salvar(DTOAcessorios acessorio) async {
    if (acessorio.id == null || acessorio.id!.isEmpty) {
      DocumentReference docRef = await _acessoriosCollection.add(acessorio.toJson());
      return docRef.id;
    } else {
      await _acessoriosCollection.doc(acessorio.id).update(acessorio.toJson());
      return acessorio.id!;
    }
  }

  Future<void> excluir(String id) async {
    await _acessoriosCollection.doc(id).delete();
  }

  Future<List<DTOAcessorios>> listar() async {
    QuerySnapshot snapshot = await _acessoriosCollection.get();
    return snapshot.docs.map((doc) {
      return DTOAcessorios.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}
