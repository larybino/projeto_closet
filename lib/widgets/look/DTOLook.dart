import 'package:projeto_lary/widgets/acessorios/DTOAcessorios.dart';
import 'package:projeto_lary/widgets/roupas/DTORoupas.dart';
import 'package:projeto_lary/widgets/sapato/DTOSapato.dart';

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