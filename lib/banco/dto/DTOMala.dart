import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOEvento.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';

class DTOMala {
  String? id;
  String? nome;
  DTOEvento? evento;
  
  List<DTORoupas> roupas;
  List<DTOSapato> sapatos;
  List<DTOAcessorios> acessorios;

  DTOMala({
    this.id,
    this.nome,
    this.evento,
    required this.roupas,
    required this.sapatos,
    required this.acessorios,
  });

  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'id_evento': evento?.id,
      'roupas_ids': roupas.map((r) => r.id).toList(),
      'sapatos_ids': sapatos.map((s) => s.id).toList(),
      'acessorios_ids': acessorios.map((a) => a.id).toList(),
    };
  }

  factory DTOMala.fromJson(Map<String, dynamic> json, String id) {
    return DTOMala(
      id: id,
      nome: json['nome'],
      roupas: [],
      sapatos: [],
      acessorios: [],
    );
  }
}
