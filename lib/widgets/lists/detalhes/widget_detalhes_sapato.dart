import 'package:flutter/material.dart';
import 'package:projeto_lary/banco/dto/DTOSapato.dart';
import 'package:projeto_lary/widgets/componentes/widget_linha_detalhe.dart';

class WidgetDetalhesSapatos extends StatelessWidget {
  final DTOSapato sapato;

  const WidgetDetalhesSapatos({super.key, required this.sapato});

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
                child: (sapato.fotoUrl != null && sapato.fotoUrl!.isNotEmpty)
                    ? Image.network(
                        sapato.fotoUrl!,
                        height: 350,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 250,
                          color: Colors.grey[200],
                          child: const Icon(Icons.error, color: Colors.red, size: 50),
                        ),
                      )
                    : Container(
                        height: 250,
                        color: Colors.grey[200],
                        child: const Icon(Icons.ice_skating, color: Colors.grey, size: 100),
                      ),
              ),
              const SizedBox(height: 20),

              Text(
                sapato.modelo ?? 'Detalhes do Sapato',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const Divider(height: 24),

              WidgetLinhaDetalhe(
                icon: Icons.style,
                label: 'Tipo',
                value: sapato.tipo,
                iconColor: corIcone,
              ),
              WidgetLinhaDetalhe(
                icon: Icons.color_lens,
                label: 'Cor',
                value: sapato.cor,
                iconColor: corIcone,
              ),
              WidgetLinhaDetalhe(
                icon: Icons.business,
                label: 'Marca',
                value: sapato.marca,
                iconColor: corIcone,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
