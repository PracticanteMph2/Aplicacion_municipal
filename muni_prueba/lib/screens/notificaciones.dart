import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';

/// Pantalla de notificaciones. Equivale a NotificacionesScreen del original
/// (components/ph/screens/notificaciones.tsx).
class NotificacionesScreen extends StatelessWidget {
  final VoidCallback? onBack;
  const NotificacionesScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final items = state.notifications;
    final unread = state.unread;

    return Scaffold(
      backgroundColor: PhColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(
              title: 'Notificaciones',
              onBack: onBack ?? () => Navigator.of(context).maybePop(),
              right: unread > 0
                  ? IconButton(
                padding: EdgeInsets.zero,
                tooltip: 'Marcar todas como leídas',
                icon: const Icon(Icons.done_all, color: Colors.white, size: 22),
                onPressed: () {
                  context.read<AppState>().markAllNotificationsRead();
                  showPhToast(context, 'Todas marcadas como leídas');
                },
              )
                  : null,
            ),
            Expanded(
              child: items.isEmpty
                  ? const EmptyBlock(message: 'No tienes notificaciones.')
                  : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) => _NotificationTile(item: items[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationStyle {
  final IconData icon;
  final Color color;
  final Color bg;
  const _NotificationStyle(this.icon, this.color, this.bg);
}

_NotificationStyle _styleFor(String type) {
  switch (type) {
    case 'beneficio':
      return const _NotificationStyle(Icons.local_activity_outlined, PhColors.blue, Color(0xFFE6EDF7));
    case 'canje':
      return const _NotificationStyle(Icons.verified_outlined, PhColors.green, Color(0xFFE7F5EE));
    case 'info':
      return const _NotificationStyle(Icons.info_outline, Color(0xFFE08A00), Color(0xFFFFF3DF));
    default:
      return const _NotificationStyle(Icons.notifications_outlined, PhColors.blue, Color(0xFFE6EDF7));
  }
}

class _NotificationTile extends StatelessWidget {
  final AppNotification item;
  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final style = _styleFor(item.type);
    return Material(
      color: item.read ? Colors.white : PhColors.blue.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: item.read
            ? null
            : () => context.read<AppState>().markNotificationRead(item.id),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: item.read
                  ? PhColors.gray100
                  : PhColors.blue.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: style.bg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(style.icon, color: style.color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: PhColors.gray900,
                            ),
                          ),
                        ),
                        if (!item.read)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: PhColors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    if (item.body != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.body!,
                        style: const TextStyle(
                          fontSize: 12,
                          height: 1.5,
                          color: PhColors.gray500,
                        ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      relativeTime(item.createdAt),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: PhColors.gray400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
