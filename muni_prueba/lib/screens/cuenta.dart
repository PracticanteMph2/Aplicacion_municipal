import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';
import 'beneficios.dart';
import 'canjes.dart';
import 'mis_datos.dart';
import 'notificaciones.dart';
import 'ayuda.dart';
import 'portada.dart';

/// Pantalla "Mi Cuenta" (equivalente a CuentaScreen). Usada como pestaña.
class CuentaScreen extends StatelessWidget {
  const CuentaScreen({super.key});

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  void _confirmLogout(BuildContext context) {
    showPhSheet(
      context,
      title: 'Cerrar sesión',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            '¿Seguro que deseas cerrar tu sesión? Volverás a la pantalla de inicio.',
            style: TextStyle(fontSize: 14, color: PhColors.gray600, height: 1.5),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<AppState>().logout();
              Navigator.of(context).pop(); // cierra sheet
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const PortadaScreen()),
                    (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: PhColors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Cerrar sesión', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: PhColors.gray100,
              foregroundColor: PhColors.gray700,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final user = state.user;
    final unread = state.unread;
    final isActive = user.status == 'activo';

    final items = <({String label, IconData icon, String? badge, VoidCallback action})>[
      (label: 'Mis Datos', icon: Icons.person_outline, badge: null, action: () => _push(context, const MisDatosScreen())),
      (label: 'Mis Beneficios', icon: Icons.workspace_premium_outlined, badge: null, action: () => _push(context, const BeneficiosScreen())),
      (label: 'Mis Canjes', icon: Icons.confirmation_number_outlined, badge: null, action: () => _push(context, const CanjesScreen())),
      (label: 'Notificaciones', icon: Icons.notifications_outlined, badge: unread > 0 ? '$unread' : null, action: () => _push(context, const NotificacionesScreen())),
      (label: 'Centro de Ayuda', icon: Icons.help_outline, badge: null, action: () => _push(context, const AyudaScreen())),
    ];

    return Column(
      children: [
        ScreenHeader(
          title: 'Mi cuenta',
          right: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () => showPhToast(context, 'Configuracion próximamente'),
            icon: const Icon(Icons.settings_outlined, color: Colors.white, size: 20),
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            children: [
              GestureDetector(
                onTap: () => _push(context, const MisDatosScreen()),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: PhColors.gray100),
                  ),
                  child: Row(
                    children: [
                      const PhLogo(size: 52),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.fullName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: PhColors.gray900)),
                            Text('ID Vecinal: ${user.vecinoId}',
                                style: const TextStyle(
                                    fontSize: 12, color: PhColors.gray500)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.check_circle,
                                    size: 16,
                                    color: isActive ? PhColors.green : PhColors.gray400),
                                const SizedBox(width: 6),
                                Text(isActive ? 'Vecino Activo' : 'Vecino Inactivo',
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: isActive
                                            ? PhColors.green
                                            : PhColors.gray400)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: PhColors.gray400),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: PhColors.gray100),
                ),
                child: Column(
                  children: List.generate(items.length, (i) {
                    final it = items[i];
                    return InkWell(
                      onTap: it.action,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: i != 0
                                ? const BorderSide(color: PhColors.gray100)
                                : BorderSide.none,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Row(
                          children: [
                            Icon(it.icon, size: 20, color: PhColors.gray600),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(it.label,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: PhColors.gray800)),
                            ),
                            if (it.badge != null)
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding:
                                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: PhColors.red,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(it.badge!,
                                    style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                            const Icon(Icons.chevron_right, color: PhColors.gray400),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _confirmLogout(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: PhColors.gray100),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.logout, size: 20, color: PhColors.red),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text('Cerrar Sesión',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: PhColors.red)),
                      ),
                      Icon(Icons.chevron_right, color: PhColors.gray400),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
