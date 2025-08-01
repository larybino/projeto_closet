import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'package:projeto_lary/banco/dto/DTORoupas.dart';

class RoupaFirebaseService {
  final _auth = FirebaseAuth.instance;

CollectionReference get _roupasCollection {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Usuário não autenticado para aceder às roupas.');
    }
    return FirebaseFirestore.instance.collection('usuarios/${user.uid}/roupas');
  }
  
  Future<String> salvar(DTORoupas roupa) async {
    if (roupa.id == null) {
      DocumentReference docRef = await _roupasCollection.add(roupa.toJson());
      return docRef.id;
    } else {
      await _roupasCollection.doc(roupa.id).update(roupa.toJson());
      return roupa.id!;
    }
  }

  Future<void> excluir(String id) async {
    await _roupasCollection.doc(id).delete();
  }

  Future<List<DTORoupas>> listar() async {
    QuerySnapshot snapshot = await _roupasCollection.get();
    return snapshot.docs.map((doc) {
      return DTORoupas.fromJson(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}