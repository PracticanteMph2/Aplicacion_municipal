import 'package:flutter/material.dart';
import '../theme.dart';
import '../models/models.dart';
import '../utils/visuals.dart';

/// Logo municipal (assets/images/logo-ph.png), equivalente a PhLogo.
class PhLogo extends StatelessWidget {
  final double size;
  const PhLogo({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo-ph.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}

/// Encabezado de pantalla de color (equivalente a ScreenHeader).
class ScreenHeader extends StatelessWidget {
  final String title;
  final Widget? titleWidget;
  final Color color;
  final VoidCallback? onBack;
  final Widget? right;
  final Widget? bottom;
  final EdgeInsetsGeometry? padding;

  const ScreenHeader({
    super.key,
    required this.title,
    this.titleWidget,
    this.color = PhColors.blue,
    this.onBack,
    this.right,
    this.bottom,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: color,
      padding: padding ?? EdgeInsets.fromLTRB(8, 12, 8, bottom != null ? 0: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 40,
                child: onBack != null
                    ? IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: onBack,
                  icon: const Icon(Icons.chevron_left, color: Colors.white, size: 26),
                )
               : const SizedBox(),
              ),
              Expanded(
                child: titleWidget ?? Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 40, child: right != null ? Center(child: right) : const SizedBox()),
            ],
          ),
          if (bottom != null) ...[
            const SizedBox(height: 8),
            bottom!,
          ],
        ],
      ),
    );
  }
}

///iconos sin logo de comercios
class MerchantIcon extends StatelessWidget{
  final Benefit benefit;
  final double size;

  const MerchantIcon({
    super.key,
    required this.benefit,
    this.size = 44
  });

  @override
  Widget build(BuildContext context) {
    final sw = benefitColor(benefit.color);

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: benefit.logo != null ? Colors.white : sw.bg,
        borderRadius: BorderRadius.circular(size * 0.28),
        border: benefit.logo != null
          ? Border.all(color: PhColors.gray100, width: 1)
          : null,
      ),
      child: benefit.logo != null
        ? Padding(
          padding: const EdgeInsets.all(4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(size * 0.2),
            child: Image.asset(
              benefit.logo!,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(benefitIcon(benefit.icon), color: sw.color, size: size * 0.45),
            ),
          ),
        )
       : Icon(benefitIcon(benefit.icon), color: sw.color, size: size * 0.45),
    );
  }
}

/// Estado de carga (LoadingBlock).
class LoadingBlock extends StatelessWidget {
  final String label;
  const LoadingBlock({super.key, this.label = 'Cargando...'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2.4, color: PhColors.blue),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: PhColors.gray400, fontSize: 14)),
        ],
      ),
    );
  }
}

/// Estado vacío (EmptyBlock).
class EmptyBlock extends StatelessWidget {
  final String message;
  const EmptyBlock({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const Icon(Icons.inbox_outlined, size: 32, color: PhColors.gray400),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: PhColors.gray400, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}

/// Muestra un toast equivalente al del original (SnackBar oscuro con check).
void showPhToast(BuildContext context, String message) {
  final messenger = ScaffoldMessenger.of(context);
  messenger.clearSnackBars();
  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: PhColors.gray900,
      duration: const Duration(milliseconds: 2600),
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: PhColors.green, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
        ],
      ),
    ),
  );
}

/// Abre un bottom sheet con título + contenido (equivalente a openSheet).
Future<void> showPhSheet(
    BuildContext context, {
  required String title,
  required Widget child,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(ctx).size.height * 0.9,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: PhColors.gray100)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 16, 12, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: PhColors.gray900,
                        ),
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.of(ctx).pop(),
                      icon: const Icon(Icons.close,
                          color: PhColors.gray400, size: 20),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
