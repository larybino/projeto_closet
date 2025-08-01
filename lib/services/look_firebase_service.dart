import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_lary/banco/dto/DTOLook.dart';
import 'package:projeto_lary/repositories/acessorio_repository.dart';
import 'package:projeto_lary/repositories/roupa_repository.dart';
import 'package:projeto_lary/repositories/sapato_repository.dart';

class LookFirebaseService {
  final _auth = FirebaseAuth.instance;
  
  CollectionReference get _looksCollection {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuário não autenticado.');
    return FirebaseFirestore.instance.collection('usuarios/${user.uid}/looks');
  }

  Future<DTOLook> _docToLook(DocumentSnapshot doc) async {
    final lookData = doc.data() as Map<String, dynamic>;
    final look = DTOLook.fromJson(lookData, doc.id);

    final roupasIds = List.from(lookData['roupas_ids'] ?? []).whereType<String>().toList();
    final sapatosIds = List.from(lookData['sapatos_ids'] ?? []).whereType<String>().toList();
    final acessoriosIds = List.from(lookData['acessorios_ids'] ?? []).whereType<String>().toList();

    // Busca todos os itens de uma vez para eficiência
    final todasRoupas = await RoupaRepository().listar();
    final todosSapatos = await SapatoRepository().listar();
    final todosAcessorios = await AcessorioRepository().listar();

    // Filtra para encontrar apenas os itens que pertencem a este look
    look.roupas = todasRoupas.where((r) => roupasIds.contains(r.id)).toList();
    look.sapatos = todosSapatos.where((s) => sapatosIds.contains(s.id)).toList();
    look.acessorios = todosAcessorios.where((a) => acessoriosIds.contains(a.id)).toList();

    return look;
  }

  Future<String> salvar(DTOLook look) async {
    if (look.id == null || look.id!.isEmpty) {
      DocumentReference docRef = await _looksCollection.add(look.toJson());
      return docRef.id;
    } else {
      await _looksCollection.doc(look.id).update(look.toJson());
      return look.id!;
    }
  }

  Future<void> excluir(String id) async {
    await _looksCollection.doc(id).delete();
  }

  Future<List<DTOLook>> listar() async {
    QuerySnapshot snapshot = await _looksCollection.get();
    return Future.wait(snapshot.docs.map((doc) => _docToLook(doc)).toList());
  }

  Future<DTOLook?> buscarPorId(String id) async {
    DocumentSnapshot doc = await _looksCollection.doc(id).get();
    if (doc.exists) {
      return await _docToLook(doc);
    }
    return null;
  }
}
