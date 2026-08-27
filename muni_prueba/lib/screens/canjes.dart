import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import 'proceso_canje.dart';

/// Pantalla "Mis Canjes" con historial real y dinámico.
class CanjesScreen extends StatelessWidget {
  const CanjesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final redemptions = state.redemptions;
    final total = state.redemptionsTotal;

    return Scaffold(
      backgroundColor: PhColors.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ScreenHeader(
              title: 'Mis Canjes',
              onBack: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: PhColors.gray100),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: PhColors.greenSoft,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.confirmation_number_outlined,
                              color: PhColors.green, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$total beneficio${total == 1 ? '' : 's'} usado${total == 1 ? '' : 's'}',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: PhColors.gray900),
                              ),
                              const Text(
                                'Toca un beneficio de tu historial para volver a utilizarlo.',
                                style: TextStyle(
                                    fontSize: 12, color: PhColors.gray500, height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (redemptions.isEmpty)
                    const EmptyBlock(
                        message: 'Todavía no has canjeado beneficios con tu tarjeta.'),
                  ...redemptions.map((r) => _RedemptionTile(r: r)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RedemptionTile extends StatelessWidget {
  final Redemption r;
  const _RedemptionTile({required this.r});

  String _short(String? d) {
    if (d == null || d.isEmpty) return 'OFF';
    final match = RegExp(r'(\d+%)').firstMatch(d);
    return match != null ? match.group(0)! : 'OFF';
  }

  void _confirmReuse(BuildContext context) {
    final state = context.read<AppState>();
    
    // 1. Buscamos el beneficio original por ID
    final benefit = state.benefits.firstWhere((b) => b.id == r.benefitId, 
      orElse: () => throw Exception('Beneficio no encontrado'));
    
    // 2. Buscamos la oferta específica dentro de ese beneficio
    final offer = benefit.offers?.firstWhere((o) => o.id == r.offerId,
      orElse: () => benefit.offers!.first);

    showPhSheet(
      context,
      title: 'Repetir Beneficio',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '¿Deseas volver a utilizar este beneficio en este comercio?',
            style: TextStyle(fontSize: 14, color: PhColors.gray600, height: 1.5),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PhColors.gray50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: PhColors.gray100),
            ),
            child: Row(
              children: [
                const Icon(Icons.store_outlined, size: 20, color: PhColors.blue),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(r.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(r.discount ?? '', style: const TextStyle(fontSize: 12, color: PhColors.green, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el sheet de confirmación
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProcesoCanjeScreen(
                    benefit: benefit,
                    offer: offer!,
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: PhColors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 0,
            ),
            child: const Text('Sí, usar ahora', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar', style: TextStyle(color: PhColors.gray500)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _confirmReuse(context),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: PhColors.gray100),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: PhColors.greenSoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(_short(r.discount),
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w800,
                                    color: PhColors.green)),
                          ),
                          const Text('dcto.',
                              style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: PhColors.green)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(r.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: PhColors.gray900)),
                          if (r.merchant != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Row(
                                children: [
                                  const Icon(Icons.store_outlined,
                                      size: 12, color: PhColors.green),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(r.merchant!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 12, color: PhColors.green)),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                    const Icon(Icons.replay_outlined, size: 20, color: PhColors.gray300),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(height: 1, color: PhColors.gray100),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(stampLabel(r.redeemedAt),
                        style: const TextStyle(fontSize: 11, color: PhColors.gray400)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: PhColors.gray100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(r.code,
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              fontFamily: 'monospace',
                              color: PhColors.gray500)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
