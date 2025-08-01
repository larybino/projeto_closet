import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_lary/banco/dto/DTOMala.dart';
import 'package:projeto_lary/repositories/acessorio_repository.dart';
import 'package:projeto_lary/repositories/evento_repository.dart';
import 'package:projeto_lary/repositories/roupa_repository.dart';
import 'package:projeto_lary/repositories/sapato_repository.dart';

class MalaFirebaseService {
  final _auth = FirebaseAuth.instance;
  
  CollectionReference get _malasCollection {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado.');
    return FirebaseFirestore.instance.collection('usuarios/${user.uid}/malas');
  }

  Future<DTOMala> _docToMala(DocumentSnapshot doc) async {
    final data = doc.data() as Map<String, dynamic>;
    final mala = DTOMala.fromJson(data, doc.id);
    
    if (data['id_evento'] != null) {
      mala.evento = await EventoRepository().buscarPorId(data['id_evento']);
    }

    final roupasIds = List.from(data['roupas_ids'] ?? []).whereType<String>().toList();
    final sapatosIds = List.from(data['sapatos_ids'] ?? []).whereType<String>().toList();
    final acessoriosIds = List.from(data['acessorios_ids'] ?? []).whereType<String>().toList();

    final todasRoupas = await RoupaRepository().listar();
    final todosSapatos = await SapatoRepository().listar();
    final todosAcessorios = await AcessorioRepository().listar();

    mala.roupas = todasRoupas.where((r) => roupasIds.contains(r.id)).toList();
    mala.sapatos = todosSapatos.where((s) => sapatosIds.contains(s.id)).toList();
    mala.acessorios = todosAcessorios.where((a) => acessoriosIds.contains(a.id)).toList();
    
    return mala;
  }

  Future<String> salvar(DTOMala mala) async {
    if (mala.id == null || mala.id!.isEmpty) {
      DocumentReference docRef = await _malasCollection.add(mala.toJson());
      return docRef.id;
    } else {
      await _malasCollection.doc(mala.id).update(mala.toJson());
      return mala.id!;
    }
  }

  Future<void> excluir(String id) async {
    await _malasCollection.doc(id).delete();
  }

  Future<List<DTOMala>> listar() async {
    QuerySnapshot snapshot = await _malasCollection.get();
    return Future.wait(snapshot.docs.map((doc) => _docToMala(doc)).toList());
  }

  Future<DTOMala?> buscarPorId(String id) async {
    DocumentSnapshot doc = await _malasCollection.doc(id).get();
    if (doc.exists) {
      return await _docToMala(doc);
    }
    return null;
  }
}
