import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_lary/banco/dto/DTOEvento.dart';
import 'package:projeto_lary/repositories/look_repository.dart';

class EventoFirebaseService {
  final _auth = FirebaseAuth.instance;
  
  CollectionReference get _eventosCollection {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado.');
    return FirebaseFirestore.instance.collection('usuarios/${user.uid}/eventos');
  }

  Future<String> salvar(DTOEvento evento) async {
    if (evento.id == null || evento.id!.isEmpty) {
      DocumentReference docRef = await _eventosCollection.add(evento.toJson());
      return docRef.id;
    } else {
      await _eventosCollection.doc(evento.id).update(evento.toJson());
      return evento.id!;
    }
  }

  Future<void> excluir(String id) async {
    await _eventosCollection.doc(id).delete();
  }

  Future<List<DTOEvento>> listar() async {
    QuerySnapshot snapshot = await _eventosCollection.get();
    
    // Para cada evento, busca o seu look completo
    return Future.wait(snapshot.docs.map((doc) async {
      final data = doc.data() as Map<String, dynamic>;
      final evento = DTOEvento.fromJson(data, doc.id);
      
      
      if (data['id_look'] != null) {
        evento.look = await LookRepository().buscarPorId(data['id_look']);
      }
      return evento;
    }).toList());
  }
}
