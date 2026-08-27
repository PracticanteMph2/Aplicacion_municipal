import 'package:flutter/material.dart';
import 'package:mi_padre_hurtado/screens/home_shell.dart';
import 'package:provider/provider.dart';
import 'state/app_state.dart';
import 'theme.dart';
import 'screens/portada.dart';

/// Punto de entrada de la aplicación "Mi Padre Hurtado".
void main() {
  runApp(const MiPadreHurtadoApp());
}

class MiPadreHurtadoApp extends StatelessWidget {
  const MiPadreHurtadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState()..init(),
      child: Consumer<AppState>(
        builder: (context, state, child){
          if (!state.initialized) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          return MaterialApp(
            title: 'Mi Padre Hurtado',
            debugShowCheckedModeBanner: false,
            theme: buildPhTheme(),
            home: state.authenticated
              ? const HomeShell()
              : const PortadaScreen(),
          );
        },
      ),
    );
  }
}
