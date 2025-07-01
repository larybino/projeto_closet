import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';

class DTOLook{
  int? id;
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
}