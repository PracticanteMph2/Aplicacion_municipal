import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; ///Paquete para redirigir a otra app en este caso maps, telefono y correo
import '../theme.dart';
import '../widgets/common.dart';

/// Centro de ayuda. Equivale a AyudaScreen del original
/// (components/ph/screens/ayuda.tsx).
class AyudaScreen extends StatefulWidget {
  final VoidCallback? onBack;
  const AyudaScreen({super.key, this.onBack});

  @override
  State<AyudaScreen> createState() => _AyudaScreenState();
}

class _Faq {
  final String q;
  final String a;
  const _Faq(this.q, this.a);
}

const _faqs = <_Faq>[
  _Faq(
    '¿Cómo obtengo mi Tarjeta Vecino Digital?',
    'Tu tarjeta se genera automáticamente al validar tu identidad en el registro. La encuentras en la pestaña Tarjeta.',
  ),
  _Faq(
    '¿Cómo reporto un problema en mi barrio?',
    'Ingresa a Reportes Ciudadanos, selecciona el tipo de problema, marca la ubicación y agrega una descripción o foto.',
  ),
  _Faq(
    '¿Cuánto demora un trámite municipal?',
    'Los tiempos varían según el trámite. Puedes seguir su estado en tiempo real desde la sección Mis Trámites.',
  ),
  _Faq(
    '¿Cómo accedo a los beneficios?',
    'Presenta el código QR de tu Tarjeta Vecino Digital en los comercios y servicios adheridos.',
  ),
];

class _Contact {
  final String label;
  final String sub;
  final IconData icon;
  const _Contact(this.label, this.sub, this.icon);
}

const _contacts = <_Contact>[
  _Contact('Llamar a la Municipalidad', '+56 2 2123 4567', Icons.phone_outlined),
  _Contact('Escribir un correo', 'contacto@padrehurtado.cl', Icons.mail_outline),
  _Contact('Chat de soporte', 'Lun a Vie, 9:00 - 18:00 hrs.', Icons.chat_bubble_outline),
  _Contact('Oficinas municipales', 'Municipalidad de Padre Hurtado', Icons.location_on_outlined),
];

class _AyudaScreenState extends State<AyudaScreen> {
  int? _open = 0;

  Future<void> _handleContact(_Contact c) async {
    Uri? url;
    if (c.icon == Icons.phone_outlined) {
      url = Uri.parse('tel:${c.sub.replaceAll(' ', '')}');
    } else if (c.icon == Icons.mail_outline) {
      url = Uri.parse('mailto:${c.sub}');
    } else if (c.icon == Icons.location_on_outlined) {
      url = Uri.https('www.google.com', '/maps/search/', {
        'api': '1',
        'query': c.sub,
      });
    }

    if (url != null) {
      try {
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        } else {
          showPhToast(context, 'No se pudo abrir la aplicación correspondiente');
        }
      } catch (e) {
        showPhToast(context, 'Error al intentar contactar');
      }
    } else {
      showPhToast(context, 'Función próximamente: ${c.label}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PhColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            ScreenHeader(
              title: 'Centro de Ayuda',
              onBack: widget.onBack ?? () => Navigator.of(context).maybePop(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                children: [
                  const Text(
                    'Contáctanos',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: PhColors.gray900),
                  ),
                  const SizedBox(height: 8),
                  ..._contacts.map((c) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _ContactCard(
                      contact: c,
                      onTap: () => _handleContact(c),
                    ),
                  )),
                  const SizedBox(height: 12),
                  const Text(
                    'Preguntas frecuentes',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: PhColors.gray900),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: PhColors.gray100),
                    ),
                    child: Column(
                      children: List.generate(_faqs.length, (i) {
                        final f = _faqs[i];
                        final isOpen = _open == i;
                        return Material(
                          color: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              border: i != 0
                                  ? const Border(top: BorderSide(color: PhColors.gray100))
                                  : null,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () => setState(() => _open = isOpen ? null : i),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            f.q,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: PhColors.gray800,
                                            ),
                                          ),
                                        ),
                                        AnimatedRotation(
                                          turns: isOpen ? 0.5 : 0,
                                          duration: const Duration(milliseconds: 180),
                                          child: const Icon(Icons.keyboard_arrow_down,
                                              size: 18, color: PhColors.gray400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (isOpen)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                    child: Text(
                                      f.a,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        height: 1.5,
                                        color: PhColors.gray500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
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

class _ContactCard extends StatelessWidget {
  final _Contact contact;
  final VoidCallback onTap;
  const _ContactCard({required this.contact, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: PhColors.gray100),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: PhColors.blue.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(contact.icon, color: PhColors.blue, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: PhColors.gray900,
                      ),
                    ),
                    Text(
                      contact.sub,
                      style: const TextStyle(fontSize: 12, color: PhColors.gray500),
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
