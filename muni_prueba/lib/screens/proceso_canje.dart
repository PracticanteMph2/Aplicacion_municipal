import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../state/app_state.dart';
import '../theme.dart';

enum SolicitudStatus { pendiente, aprobado, rechazado }

class ProcesoCanjeScreen extends StatefulWidget {
  final Benefit benefit;
  final Offer offer;

  const ProcesoCanjeScreen({super.key, required this.benefit, required this.offer});

  @override
  State<ProcesoCanjeScreen> createState() => _ProcesoCanjeScreenState();
}

class _ProcesoCanjeScreenState extends State<ProcesoCanjeScreen> {
  SolicitudStatus _status = SolicitudStatus.pendiente;
  String _mensajeRechazo = 'Límite de uso diario alcanzado';

  @override
  void initState() {
    super.initState();
    _iniciarSolicitud();
  }

  Future<void> _iniciarSolicitud() async {
    await Future.delayed(const Duration(seconds: 4));
    if (!mounted) return;

    final bool simulacionAprobada = true;

    if (simulacionAprobada) {
      final state = context.read<AppState>();
      state.registerRedemption(widget.benefit, widget.offer);
      if (!widget.benefit.assigned) state.activateBenefit(widget.benefit.id);

      setState(() => _status = SolicitudStatus.aprobado);
    } else {
      setState(() => _status = SolicitudStatus.rechazado);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand( // Forzamos a que ocupe TODA la pantalla
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centrado vertical
              crossAxisAlignment: CrossAxisAlignment.center, // Centrado horizontal
              children: [
                if (_status == SolicitudStatus.pendiente) _buildPendiente(),
                if (_status == SolicitudStatus.aprobado) _buildAprobado(),
                if (_status == SolicitudStatus.rechazado) _buildRechazado(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPendiente() {
    return Column(
      children: [
        const SizedBox(
          width: 64,
          height: 64,
          child: CircularProgressIndicator(strokeWidth: 6, color: PhColors.blue),
        ),
        const SizedBox(height: 40),
        const Text('Solicitud enviada con éxito',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: PhColors.gray900)),
        const SizedBox(height: 16),
        Text('Esperando confirmación de\n${widget.benefit.merchant ?? widget.benefit.title}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: PhColors.gray500, height: 1.5)),
      ],
    );
  }

  Widget _buildAprobado() {
    return Column(
      children: [
        const Icon(Icons.check_circle_outline, size: 100, color: PhColors.green),
        const SizedBox(height: 32),
        const Text('¡Beneficio aprobado!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: PhColors.green)),
        const SizedBox(height: 16),
        Text('Diríjase al comercio para utilizar su descuento en:\n"${widget.offer.title}"',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: PhColors.gray700, height: 1.5)),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
                backgroundColor: PhColors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0),
            child: const Text('ENTENDIDO', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 1)),
          ),
        ),
      ],
    );
  }

  Widget _buildRechazado() {
    return Column(
      children: [
        const Icon(Icons.error_outline, size: 100, color: PhColors.red),
        const SizedBox(height: 32),
        const Text('Solicitud rechazada',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: PhColors.red)),
        const SizedBox(height: 16),
        Text('Motivo: $_mensajeRechazo',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: PhColors.gray700, height: 1.5)),
        const SizedBox(height: 48),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('VOLVER ATRÁS', style: TextStyle(color: PhColors.gray500, fontWeight: FontWeight.w800, letterSpacing: 1)),
          ),
        ),
      ],
    );
  }
}
