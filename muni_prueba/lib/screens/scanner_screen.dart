import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  bool _scanned = false; // Para evitar que escanee 100 veces el mismo código

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear Convenio',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: PhColors.gray900,
        elevation: 0,
      ),
      body: MobileScanner(
        onDetect: (capture) {
          if (_scanned) return; // Si ya detectamos uno, no hacemos nada más

          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final String? code = barcode.rawValue;
            if (code != null) {
              setState(() => _scanned = true);
              _handleCode(context, code);
            }
          }
        },
      ),
    );
  }

  void _handleCode(BuildContext context, String code) {
    final state = context.read<AppState>();

    try {
      // 1. Buscamos el beneficio que coincida con el ID del QR
      final benefit = state.benefits.firstWhere((b) => b.id == code);

      // 2. Si lo encontramos, cerramos la cámara y abrimos su ficha
      Navigator.of(context).pop(benefit);

    } catch (e) {
      // Si el QR no es un ID válido de nuestra lista
      setState(() => _scanned = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Código de convenio no válido')),
      );
    }
  }
}