import 'package:projeto_lary/widgets/acessorios/DTOAcessorios.dart';
import 'package:projeto_lary/widgets/roupas/DTORoupas.dart';
import 'package:projeto_lary/widgets/sapato/DTOSapato.dart';

class DTOLook{
  List<DTORoupas> roupas;
  List<DTOSapato> sapatos;
  List<DTOAcessorios> acessorios;


  DTOLook({
    required this.roupas,
    required this.sapatos,
    required this.acessorios,
  });
}