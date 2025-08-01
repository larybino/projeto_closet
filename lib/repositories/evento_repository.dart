import 'package:projeto_lary/banco/dao/eventoDAO.dart';
import 'package:projeto_lary/banco/dto/DTOEvento.dart';
import 'package:projeto_lary/services/evento_firebase_service.dart';

class EventoRepository {
  final _localDAO = EventoDAO();
  final _firebaseService = EventoFirebaseService();

  Future<void> salvar(DTOEvento evento) async {
    final id = await _firebaseService.salvar(evento);
    evento.id = id;
    await _localDAO.salvar(evento);
  }

  Future<void> excluir(DTOEvento evento) async {
    if (evento.id != null) {
      await _firebaseService.excluir(evento.id!);
      await _localDAO.excluir(evento.id!);
    }
  }

  Future<List<DTOEvento>> listar() async {
    try {
      final eventosRemotos = await _firebaseService.listar();
      await _localDAO.sincronizar(eventosRemotos);
      return eventosRemotos;
    } catch (e) {
      print('Falha ao conectar ao Firebase, retornando dados locais: $e');
      return await _localDAO.listar();
    }
  }
}