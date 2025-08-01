import 'package:projeto_lary/banco/dto/DTOLook.dart';

class DTOEvento {
  String? id;
  String? nome;
  String? data;
  DTOLook? look;

  DTOEvento({this.id, this.nome, this.data, this.look});

  // Converte um objeto DTOEvento para um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'data': data,
      // No banco, guardamos apenas o ID do look.
      'id_look': look?.id,
    };
  }

  // Converte um Map para um objeto DTOEvento
  // Note que o look é recebido separadamente, pois virá de outro DAO.
  static DTOEvento fromMap(Map<String, dynamic> map, {DTOLook? look}) {
    return DTOEvento(
      id: map['id']?.toString(),
      nome: map['nome'],
      data: map['data'],
      look: look, // O look completo é associado aqui.
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'data': data,
      'id_look': look?.id,
    };
  }

  /// Cria um objeto a partir de um JSON do Firebase.
  /// A propriedade 'look' será preenchida depois pelo repositório.
  factory DTOEvento.fromJson(Map<String, dynamic> json, String id) {
    return DTOEvento(
      id: id,
      nome: json['nome'],
      data: json['data'],
    );
  }
}