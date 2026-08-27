import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import '../widgets/vecino_card.dart';
import 'beneficios.dart';

/// Pantalla de la Tarjeta Vecino (equivalente a TarjetaScreen).
class TarjetaScreen extends StatelessWidget {
  const TarjetaScreen({super.key});

  void _openBeneficios(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BeneficiosScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final active = context.watch<AppState>().assignedBenefits;
    final preview = active.take(4).toList(); ///iconos benefios activos
    final rest = active.length - preview.length;

    return Column(
      children: [
        ScreenHeader(
          title: 'Tarjeta Vecino Digital',
          right: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () => showPhToast(context, 'Tarjeta compartida'),
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            tooltip: 'Opciones',
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              const VecinoCard(
                footerLink: Text('Escanea para validar',
                    style: TextStyle(fontSize: 12, color: PhColors.gray400)),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: PhColors.gray100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Beneficios activos (${active.length})',
                            style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: PhColors.gray900)),
                        GestureDetector(
                          onTap: () => _openBeneficios(context),
                          child: const Text('Ver todos',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: PhColors.green)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ...preview.map((b) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () => _openBeneficios(context),
                              child: MerchantIcon(benefit: b, size: 48),
                            ),
                          );
                        }),
                        if (rest > 0)
                          GestureDetector(
                            onTap: () => _openBeneficios(context),
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: PhColors.gray100,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Text('+$rest',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: PhColors.gray500)),
                              ),
                            ),
                          ),
                        if (active.isEmpty)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Aún no tienes beneficios activos.',
                                style: TextStyle(
                                    fontSize: 12, color: PhColors.gray400)),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: PhColors.blue.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, color: PhColors.blue, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Información importante',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: PhColors.gray900)),
                          SizedBox(height: 2),
                          Text(
                            'Presenta tu tarjeta para acceder a beneficios y servicios municipales.',
                            style: TextStyle(
                                fontSize: 12,
                                color: PhColors.gray500,
                                height: 1.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
