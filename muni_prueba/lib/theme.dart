import 'package:flutter/material.dart';

/// Tokens de color de la app, equivalentes a las variables CSS `--ph-*`
/// del proyecto original (globals.css).
class PhColors {
  static const blue = Color(0xFF003B93);
  static const blueDark = Color(0xFF002A6B);
  static const green = Color(0xFF008744);
  static const greenDark = Color(0xFF006B35);
  static const red = Color(0xFFFF3B30);
  static const purple = Color(0xFF6B4EFF);
  static const bg = Color(0xFFF4F6F9);

  // Grises usados como text-gray-* / border-gray-* en el original.
  static const gray900 = Color(0xFF111827);
  static const gray800 = Color(0xFF1F2937);
  static const gray700 = Color(0xFF374151);
  static const gray600 = Color(0xFF4B5563);
  static const gray500 = Color(0xFF6B7280);
  static const gray400 = Color(0xFF9CA3AF);
  static const gray300 = Color(0xFFD1D5DB);
  static const gray200 = Color(0xFFE5E7EB);
  static const gray100 = Color(0xFFF3F4F6);
  static const gray50 = Color(0xFFF9FAFB);

  // Fondos suaves de iconos de beneficios/categorías.
  static const greenSoft = Color(0xFFE7F5EE);
  static const blueSoft = Color(0xFFE6EDF7);
  static const purpleSoft = Color(0xFFECE9FF);
  static const redSoft = Color(0xFFFDE8E7);
  static const orangeSoft = Color(0xFFFFF3DF);
  static const orange = Color(0xFFE08A00);
  static const blueTile = Color(0xFFDBE8FB);
}

ThemeData buildPhTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: PhColors.bg,
    colorScheme: ColorScheme.fromSeed(
      seedColor: PhColors.blue,
      primary: PhColors.blue,
      secondary: PhColors.green,
    ),
    // Geist no está disponible offline; usamos la fuente por defecto del sistema.
    // Para replicar Geist puedes agregar el paquete google_fonts y usar Inter.
    fontFamily: null,
    splashFactory: InkRipple.splashFactory,
  );
}
