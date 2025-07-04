import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOAcessorios.dart';
import 'package:projeto_lary/widgets/componentes/widget_linha_detalhe.dart';

class WidgetDetalhesAcessorios extends StatelessWidget {
  final DTOAcessorios acessorio;

  const WidgetDetalhesAcessorios({super.key, required this.acessorio});

  @override
  Widget build(BuildContext context) {
    const Color corIcone = Color.fromARGB(255, 243, 33, 219);

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child:
                    (acessorio.fotoUrl != null && acessorio.fotoUrl!.isNotEmpty)
                        ? Image.network(
                          acessorio.fotoUrl!,
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder:
                              (context, error, stackTrace) => Container(
                                height: 250,
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                  size: 50,
                                ),
                              ),
                        )
                        : Container(
                          height: 250,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.watch,
                            color: Colors.grey,
                            size: 100,
                          ),
                        ),
              ),
              const SizedBox(height: 20),

              Text(
                acessorio.modelo ??
                    'Detalhes do Acessório', 
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const Divider(height: 24),

              WidgetLinhaDetalhe(
                icon: Icons.style,
                label: 'Tipo',
                value: acessorio.tipo,
                iconColor: corIcone,
              ),
              WidgetLinhaDetalhe(
                icon: Icons.color_lens,
                label: 'Cor',
                value: acessorio.cor,
                iconColor: corIcone,
              ),
              WidgetLinhaDetalhe(
                icon: Icons.business,
                label: 'Marca',
                value: acessorio.marca,
                iconColor: corIcone,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
