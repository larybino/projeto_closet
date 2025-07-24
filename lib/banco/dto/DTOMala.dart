import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/banco/dto/DTOEvento.dart';
import 'package:projeto_lary/banco/dto/DTORoupas.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';

class DTOMala {
  int? id;
  String nome;
  DTOEvento? evento;
  List<DTORoupas> roupas;
  List<DTOSapato> sapatos;
  List<DTOAcessorios> acessorios;

  DTOMala({
    this.id,
    required this.nome,
    this.evento,
    required this.roupas,
    required this.sapatos,
    required this.acessorios,
  });
}
