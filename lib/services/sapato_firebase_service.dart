import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';

class SapatoFirebaseService {
  final _auth = FirebaseAuth.instance;
  
  CollectionReference get _sapatosCollection {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado.');
    return FirebaseFirestore.instance.collection('usuarios/${user.uid}/sapatos');
  }

  Future<String> salvar(DTOSapato sapato) async {
    if (sapato.id == null || sapato.id!.isEmpty) {
      DocumentReference docRef = await _sapatosCollection.add(sapato.toJson());
      return docRef.id;
    } else {
      await _sapatosCollection.doc(sapato.id).update(sapato.toJson());
      return sapato.id!;
    }
  }

  Future<void> excluir(String id) async {
    await _sapatosCollection.doc(id).delete();
  }

  Future<List<DTOSapato>> listar() async {
    QuerySnapshot snapshot = await _sapatosCollection.get();
    return snapshot.docs.map((doc) {
      return DTOSapato.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}
