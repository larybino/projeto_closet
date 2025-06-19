import 'package:flutter/material.dart';
import 'package:projeto_lary/widgets/acessorios/DTOAcessorios.dart';
import 'package:projeto_lary/widgets/roupas/DTORoupas.dart';
import 'package:projeto_lary/widgets/sapato/DTOSapato.dart';


class WidgetCadastroLook extends StatefulWidget {
  @override
  State<WidgetCadastroLook> createState() => _WidgetCadastroLookState();
}

class _WidgetCadastroLookState extends State<WidgetCadastroLook> {
  // Simulando dados cadastrados
  final List<DTORoupas> roupasDisponiveis = [
    DTORoupas(id: '1', modelo: 'Camiseta Branca', tipo: 'Casual', cor: 'Branco', marca: 'Marca A', fotoUrl: 'url1'),
    DTORoupas(id: '2', modelo: 'Camisa Azul', tipo: 'Formal', cor: 'Azul', marca: 'Marca B', fotoUrl: 'url2'),
    DTORoupas(id: '3', modelo: 'Calça Jeans', tipo: 'Casual', cor: 'Azul', marca: 'Marca C', fotoUrl: 'url3'),
  ];

  final List<DTOSapato> sapatosDisponiveis = [
    DTOSapato(id: '1', modelo: 'Tênis Branco', material: 'Couro', cor: 'Branco', marca: 'Marca X', fotoUrl: 'url4'),
    DTOSapato(id: '2', modelo: 'Sapatênis Preto', material: 'Tecido', cor: 'Preto', marca: 'Marca Y', fotoUrl: 'url5'),
  ];

  final List<DTOAcessorios> acessoriosDisponiveis = [
    DTOAcessorios(id: '1', estilo: 'Relógio', material: 'Aço', cor: 'Prata', marca: 'Marca Z', fotoUrl: 'url6'),
    DTOAcessorios(id: '2', estilo: 'Pulseira', material: 'Couro', cor: 'Marrom', marca: 'Marca W', fotoUrl: 'url7'),
  ];

  // Seleções
  List<DTORoupas> roupasSelecionadas = [];
  List<DTOSapato> sapatosSelecionados = [];
  List<DTOAcessorios> acessoriosSelecionados = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Look'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 240, 174, 226),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            const Text(
              'Selecione as roupas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...roupasDisponiveis.map((r) => CheckboxListTile(
                  title: Text(r.modelo ?? 'Modelo desconhecido'),
                  value: roupasSelecionadas.contains(r),
                  onChanged: (bool? value) {
                    setState(() {
                      value == true
                          ? roupasSelecionadas.add(r)
                          : roupasSelecionadas.remove(r);
                    });
                  },
                )),

            const SizedBox(height: 20),
            const Text(
              'Selecione os sapatos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...sapatosDisponiveis.map((s) => CheckboxListTile(
                  title: Text(s.modelo ?? 'Modelo desconhecido'),
                  value: sapatosSelecionados.contains(s),
                  onChanged: (bool? value) {
                    setState(() {
                      value == true
                          ? sapatosSelecionados.add(s)
                          : sapatosSelecionados.remove(s);
                    });
                  },
                )),

            const SizedBox(height: 20),
            const Text(
              'Selecione os acessórios:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...acessoriosDisponiveis.map((a) => CheckboxListTile(
                  title: Text(a.estilo ?? 'Estilo desconhecido'),
                  value: acessoriosSelecionados.contains(a),
                  onChanged: (bool? value) {
                    setState(() {
                      value == true
                          ? acessoriosSelecionados.add(a)
                          : acessoriosSelecionados.remove(a);
                    });
                  },
                )),

            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: salvarLook,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 33, 219),
              ),
              child: const Text('Salvar Look'),
            ),
          ],
        ),
      ),
    );
  }

  void salvarLook() {
    final snackBar = SnackBar(
      content: Text(
        'Look salvo com:\n'
        '${roupasSelecionadas.length} roupa(s), '
        '${sapatosSelecionados.length} sapato(s), '
        '${acessoriosSelecionados.length} acessório(s)',
      ),
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
