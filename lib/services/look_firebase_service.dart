// NOVO FICHEIRO: lib/services/look_firebase_service.dart

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
    
    return Future.wait(snapshot.docs.map((doc) async {
      final lookData = doc.data() as Map<String, dynamic>;
      final look = DTOLook.fromJson(lookData, doc.id);

      final roupasIds = List<String>.from(lookData['roupas_ids'] ?? []);
      final sapatosIds = List<String>.from(lookData['sapatos_ids'] ?? []);
      final acessoriosIds = List<String>.from(lookData['acessorios_ids'] ?? []);

      look.roupas = (await RoupaRepository().listar()).where((r) => roupasIds.contains(r.id)).toList();
      look.sapatos = (await SapatoRepository().listar()).where((s) => sapatosIds.contains(s.id)).toList();
      look.acessorios = (await AcessorioRepository().listar()).where((a) => acessoriosIds.contains(a.id)).toList();

      return look;
    }).toList());
  }
}


