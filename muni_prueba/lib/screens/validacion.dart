import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme.dart';
import 'home_shell.dart';

/// Validación de identidad (equivalente a ValidacionScreen).
class ValidacionScreen extends StatefulWidget {
  const ValidacionScreen({super.key});

  @override
  State<ValidacionScreen> createState() => _ValidacionScreenState();
}

class _ValidacionScreenState extends State<ValidacionScreen> {
  final _rut = TextEditingController(text: '12.345.678-4');
  final _birth = TextEditingController(text: '1985-05-12');
  final _phone = TextEditingController(text: '+56 9 1234 5678');
  bool _accepted = true;
  bool _loading = false;

  @override
  void dispose() {
    _rut.dispose();
    _birth.dispose();
    _phone.dispose();
    super.dispose();
  }

  Future<void> _continue() async {
    setState(() => _loading = true);
    // Bypass equivalente al original: siempre entra.
    context.read<AppState>().login(rut: _rut.text, birthdate: _birth.text);
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const HomeShell()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 4),
              child: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: const Icon(Icons.chevron_left,
                    color: PhColors.gray700, size: 26),
                tooltip: 'Volver',
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: PhColors.blue.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.verified_user_outlined,
                                color: PhColors.blue, size: 28),
                          ),
                          const SizedBox(height: 16),
                          const Text('Validemos tu identidad',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: PhColors.gray900)),
                          const SizedBox(height: 8),
                          const Text(
                            'Para ofrecerte una mejor experiencia, necesitamos validar tu identidad.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                color: PhColors.gray500,
                                height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    _Field(label: 'RUT', controller: _rut),
                    const SizedBox(height: 16),
                    _Field(
                        label: 'Fecha de nacimiento',
                        controller: _birth,
                        suffix: Icons.calendar_today_outlined),
                    const SizedBox(height: 16),
                    _Field(
                        label: 'Número de teléfono',
                        controller: _phone,
                        keyboardType: TextInputType.phone),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => setState(() => _accepted = !_accepted),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(top: 2),
                            decoration: BoxDecoration(
                              color: _accepted ? PhColors.green : Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: _accepted
                                      ? PhColors.green
                                      : PhColors.gray300),
                            ),
                            child: _accepted
                                ? const Icon(Icons.check,
                                size: 14, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text.rich(
                              TextSpan(
                                style: TextStyle(
                                    fontSize: 12,
                                    color: PhColors.gray600,
                                    height: 1.5),
                                children: [
                                  TextSpan(text: 'Acepto los '),
                                  TextSpan(
                                      text: 'Términos y Condiciones',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: PhColors.blue)),
                                  TextSpan(text: ' y la '),
                                  TextSpan(
                                      text: 'Política de Privacidad',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: PhColors.blue)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _loading ? null : _continue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PhColors.green,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: _loading
                            ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white)),
                            SizedBox(width: 8),
                            Text('Validando...',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600)),
                          ],
                        )
                            : const Text('Continuar',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: GestureDetector(
                        onTap: _loading ? null : _continue,
                        child: const Text.rich(
                          TextSpan(
                            style: TextStyle(
                                fontSize: 12, color: PhColors.gray500),
                            children: [
                              TextSpan(text: '¿Ya tienes cuenta?  '),
                              TextSpan(
                                  text: 'Inicia sesión',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: PhColors.green)) ,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData? suffix;
  final TextInputType? keyboardType;

  const _Field({
    required this.label,
    required this.controller,
    this.suffix,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: PhColors.gray700)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14, color: PhColors.gray900),
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            suffixIcon: suffix != null
                ? Icon(suffix, size: 20, color: PhColors.gray400)
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: PhColors.gray200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: PhColors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
