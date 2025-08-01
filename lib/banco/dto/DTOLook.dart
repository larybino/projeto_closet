import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';

class DTOLook{
  String? id;
  String? nome;
  List<DTORoupas> roupas;
  List<DTOSapato> sapatos;
  List<DTOAcessorios> acessorios;


  DTOLook({
    this.id,
    this.nome,
    required this.roupas,
    required this.sapatos,
    required this.acessorios,
  });

   Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'roupas_ids': roupas.map((r) => r.id).toList(),
      'sapatos_ids': sapatos.map((s) => s.id).toList(),
      'acessorios_ids': acessorios.map((a) => a.id).toList(),
    };
  }

  factory DTOLook.fromJson(Map<String, dynamic> json, String id) {
    return DTOLook(
      id: id,
      nome: json['nome'],
      roupas: [],
      sapatos: [],
      acessorios: [],
    );
  }
}