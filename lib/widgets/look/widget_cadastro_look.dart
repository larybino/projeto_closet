import 'package:flutter/material.dart';

class WidgetCadastroLook extends StatefulWidget {
  @override
  State<WidgetCadastroLook> createState() => _WidgetCadastroLookState();
}

class _WidgetCadastroLookState extends State<WidgetCadastroLook> {
  final roupasSelecionadas = [
    {
      'nome': 'Vestido Floral',
      'tipo': 'Vestido',
      'cor': 'Multicolorido',
      'marca': 'Farm',
      'imagem':
          'https://lojafarm.vteximg.com.br/arquivos/ids/3411470/331280_49147_1-VESTIDO-LONGO-FLORAL-DE-VERAO.jpg?v=638590753519000000',
    },
    {
      'nome': 'Vestido de tricô plissado',
      'tipo': 'Vestido',
      'cor': 'Vermelho',
      'marca': 'Balmain',
      'imagem': 'https://cdn11.bigcommerce.com/s-2w3d34av6x/images/stencil/1280x1280/products/12889/77298/grrly-grrls-crimson-elegance-turtleneck-gown__05612.1734861376.jpg?c=1',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Look'),
        backgroundColor: const Color.fromARGB(255, 243, 33, 219),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Selecione as roupas para o look:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: roupasSelecionadas.length,
                itemBuilder: (context, index) {
                  final roupa = roupasSelecionadas[index];
                  final imagem = roupa['imagem'] as String;

                  Widget imagemWidget;
                    imagemWidget = Image.network(
                      imagem,
                      height: 350,
                      fit: BoxFit.cover,
                    );
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: imagemWidget,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Look salvo com ${roupasSelecionadas.length} peças')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 33, 219),
              ),
              child: const Text('Salvar Look'),
            )
          ],
        ),
      ),
    );
  }
}
