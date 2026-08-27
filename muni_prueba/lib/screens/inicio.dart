import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../data/mock_data.dart';
import '../widgets/vecino_card.dart';
import 'beneficios.dart';
import 'canjes.dart';
import 'notificaciones.dart';

/// Pantalla de inicio (equivalente a InicioScreen).
class InicioScreen extends StatelessWidget {
  final ValueChanged<int> onGoToTab;
  const InicioScreen({super.key, required this.onGoToTab});

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final user = state.user;
    final unread = state.unread;
    final news = kNews.first;

    final quick = [
      (
      label: 'Beneficios',
      icon: Icons.confirmation_number_outlined,
      color: PhColors.green,
      bg: PhColors.greenSoft,
      onTap: () => _push(context, const BeneficiosScreen())
      ),
      (
      label: 'Historial',
      icon: Icons.fact_check_outlined,
      color: PhColors.green,
      bg: PhColors.greenSoft,
      onTap: () => _push(context, const CanjesScreen())
      ),
      (
      label: 'Noticias',
      icon: Icons.article_outlined,
      color: PhColors.blue,
      bg: PhColors.blueSoft,
      onTap: () => onGoToTab(2)
      ),
    ];

    return Column(
      children: [
        Container(
          width: double.infinity,
          color: PhColors.blue,
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hola, ${user.firstName}',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    const SizedBox(height: 2),
                    Text('¡Qué bueno tenerte aquí!',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.8))),
                  ],
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  IconButton(
                    onPressed: () =>
                        _push(context, const NotificacionesScreen()),
                    icon: const Icon(Icons.notifications_outlined,
                        color: Colors.white),
                    tooltip: 'Notificaciones',
                  ),
                  if (unread > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: PhColors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: PhColors.blue, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Transform.translate(
            offset: const Offset(0, -12),
            child: Container(
              decoration: const BoxDecoration(
                color: PhColors.bg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  VecinoCard(
                    footerLink: GestureDetector(
                      onTap: () => _push(context, const BeneficiosScreen()),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Ver mis beneficios',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: PhColors.blue)),
                          Icon(Icons.chevron_right,
                              size: 16, color: PhColors.blue),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: quick.map((q) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: q.onTap,
                          child: Column(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: q.bg,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Icon(q.icon, color: q.color, size: 24),
                              ),
                              const SizedBox(height: 8),
                              Text(q.label,
                                  style: const TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: PhColors.gray700)),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text('Última noticia',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: PhColors.gray900)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => onGoToTab(2),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: PhColors.gray100),
                      ),
                      child: Row(
                        children: [
                          if (news.img != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(news.img!,
                                  width: 80, height: 64, fit: BoxFit.cover),
                            ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(news.title.toUpperCase(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        height: 1.3,
                                        color: PhColors.gray900)),
                                const SizedBox(height: 4),
                                const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Leer más',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: PhColors.blue)),
                                    Icon(Icons.chevron_right,
                                        size: 12, color: PhColors.blue),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
