import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import 'common.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// Tarjeta Vecino Digital (equivalente a VecinoCard).
class VecinoCard extends StatelessWidget {
  final bool showLogo;
  final Widget? footerLink;

  const VecinoCard({super.key, this.showLogo = true, this.footerLink});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().user;
    final isActive = user.status == 'activo';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border:
        Border.all(color: PhColors.blue.withValues(alpha: 0.15), width: 2),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'TARJETA VECINO DIGITAL',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              color: PhColors.blue,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (showLogo) ...[
                const PhLogo(size: 56),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: PhColors.gray900,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('ID Vecinal: ${user.vecinoId}',
                        style: const TextStyle(
                            fontSize: 12, color: PhColors.gray500)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.check_circle,
                            size: 16,
                            color:
                            isActive ? PhColors.green : PhColors.gray400),
                        const SizedBox(width: 6),
                        Text(
                          isActive ? 'Vecino Activo' : 'Vecino Inactivo',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isActive ? PhColors.green : PhColors.gray400,
                          ),
                        ),
                      ],
                    ),
                    Text('Vigente hasta ${formatDate(user.validUntil)}',
                        style: const TextStyle(
                            fontSize: 12, color: PhColors.gray500)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: PhColors.gray100),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04), blurRadius: 6),
              ],
            ),///QR del Vecino
            child: QrImageView(
              data: user.vecinoId,
              version: QrVersions.auto,
              size: 160.0,
              backgroundColor: Colors.white,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: PhColors.blue,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: PhColors.blue,
              ),
            ),
          ),
          if (footerLink != null) ...[
            const SizedBox(height: 12),
            footerLink!,
          ],
        ],
      ),
    );
  }
}
