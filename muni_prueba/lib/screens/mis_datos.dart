import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../widgets/common.dart';

/// Pantalla "Mis Datos" (equivalente a MisDatosScreen).
class MisDatosScreen extends StatefulWidget {
  const MisDatosScreen({super.key});

  @override
  State<MisDatosScreen> createState() => _MisDatosScreenState();
}

class _MisDatosScreenState extends State<MisDatosScreen> {
  late TextEditingController _phone;
  late TextEditingController _email;
  late TextEditingController _address;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<AppState>().user;
    _phone = TextEditingController(text: user.phone);
    _email = TextEditingController(text: user.email);
    _address = TextEditingController(text: user.address);
  }

  @override
  void dispose() {
    _phone.dispose();
    _email.dispose();
    _address.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    context.read<AppState>().updateMe(
      phone: _phone.text,
      email: _email.text,
      address: _address.text,
    );
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() => _saving = false);
    showPhToast(context, 'Datos actualizados correctamente');
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().user;

    return Scaffold(
      backgroundColor: PhColors.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            ScreenHeader(
              title: 'Mis Datos',
              onBack: () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  _ReadOnlyField(
                      label: 'Nombre completo',
                      icon: Icons.person_outline,
                      value: user.fullName),
                  const SizedBox(height: 16),
                  _ReadOnlyField(
                      label: 'RUT', icon: Icons.badge_outlined, value: user.rut),
                  const SizedBox(height: 16),
                  _EditableField(
                      label: 'Teléfono',
                      icon: Icons.phone_outlined,
                      controller: _phone,
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 16),
                  _EditableField(
                      label: 'Correo electrónico',
                      icon: Icons.mail_outline,
                      controller: _email,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 16),
                  _EditableField(
                      label: 'Dirección',
                      icon: Icons.location_on_outlined,
                      controller: _address),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _saving ? null : _save,
                      icon: _saving
                          ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.save_outlined, size: 18),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PhColors.blue,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      label: Text(_saving ? 'Guardando...' : 'Guardar cambios',
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  const _ReadOnlyField({required this.label, required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: PhColors.gray700)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: PhColors.gray50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: PhColors.gray200),
          ),
          child: Row(
            children: [
              Icon(icon, size: 16, color: PhColors.gray400),
              const SizedBox(width: 10),
              Expanded(
                child: Text(value,
                    style: const TextStyle(fontSize: 14, color: PhColors.gray500)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _EditableField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  const _EditableField({
    required this.label,
    required this.icon,
    required this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: PhColors.gray700)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 14, color: PhColors.gray900),
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(icon, size: 18, color: PhColors.gray400),
            prefixIconConstraints: const BoxConstraints(minWidth: 40),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
