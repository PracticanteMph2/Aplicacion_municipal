import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme.dart';
import 'scanner_screen.dart';
import 'beneficios.dart';
import 'inicio.dart';
import 'tarjeta.dart';
import 'noticias.dart';
import 'cuenta.dart';

/// Contenedor principal con barra inferior (equivalente al Shell + BottomNav).
/// Las pantallas secundarias (beneficios, canjes, mis datos, notificaciones,
/// ayuda) se abren con Navigator.push.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  void _setIndex(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = [
      InicioScreen(onGoToTab: _setIndex),
      const TarjetaScreen(),
      const NoticiasScreen(),
      const CuentaScreen(),
    ];

    return Scaffold(
      backgroundColor: PhColors.bg,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(index: _index, children: pages),
      ),
      bottomNavigationBar: _BottomNav(active: _index, onTap: _setIndex),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int active;
  final ValueChanged<int> onTap;
  const _BottomNav({required this.active, required this.onTap});

  static const _tabs = [
    (label: 'Inicio', icon: Icons.home_outlined),
    (label: 'Tarjeta', icon: Icons.badge_outlined),
    (label: 'Noticias', icon: Icons.article_outlined),
    (label: 'Mi Cuenta', icon: Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: PhColors.gray200)),
        boxShadow: [
          BoxShadow(color: Color(0x0F000000), blurRadius: 16, offset: Offset(0, -4)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              _buildTab(0),
              _buildTab(1),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ScannerScreen()),
                    );

                    if (result != null && result is Benefit && context.mounted) {
                      showBenefitDetails(context, result);
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: PhColors.green,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.qr_code_scanner,
                            color: Colors.white, size: 24),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Escanear',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: PhColors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              _buildTab(2),
              _buildTab(3),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildTab(int index){
    final t = _tabs[index];
    final selected = index == active;
    final color = selected ? PhColors.blue : PhColors.gray500;

    return Expanded(
        child: InkWell(
          onTap: () => onTap(index),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(t.icon, size:22, color: color ),
                const SizedBox(height: 4),
                Text(
                  t.label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
