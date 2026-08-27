import 'package:flutter/material.dart';
import '../theme.dart';

/// Mapea los nombres semánticos de icono a iconos de Material Design.
IconData benefitIcon(String name) {
  switch (name) {
    case 'pill':
      return Icons.medication_outlined;
    case 'hospital':
      return Icons.medical_services_outlined;
    case 'glasses':
      return Icons.visibility_outlined;
    case 'heart':
      return Icons.monitor_heart_outlined;
    case 'pets':
      return Icons.pets_outlined;
    case 'liquor':
      return Icons.liquor_outlined;
    case 'restaurant':
      return Icons.restaurant_outlined;
    case 'car':
      return Icons.directions_car_outlined;
    case 'waves':
      return Icons.pool_outlined;
    case 'tag':
      return Icons.local_offer_outlined;
    case 'dumbbell':
      return Icons.fitness_center;
    case 'book':
      return Icons.menu_book_outlined;
    case 'palette':
      return Icons.palette_outlined;
    case 'bike':
      return Icons.directions_bike;
    case 'icecream':
      return Icons.icecream_outlined;
    case 'church':
      return Icons.church_outlined;
    case 'wine':
      return Icons.wine_bar_outlined;
    case 'store':
    case 'comercios':
      return Icons.store_outlined;
    default:
      return Icons.confirmation_number_outlined; // Ticket
  }
}

class Swatch {
  final Color color;
  final Color bg;
  const Swatch(this.color, this.bg);
}

Swatch benefitColor(String name) {
  switch (name) {
    case 'green':
      return const Swatch(PhColors.green, PhColors.greenSoft);
    case 'blue':
      return const Swatch(PhColors.blue, PhColors.blueSoft);
    case 'purple':
      return const Swatch(PhColors.purple, PhColors.purpleSoft);
    case 'red':
      return const Swatch(PhColors.red, PhColors.redSoft);
    case 'orange':
      return const Swatch(PhColors.orange, PhColors.orangeSoft);
    default:
      return const Swatch(PhColors.blue, PhColors.blueSoft);
  }
}

class CategoryMeta {
  final String name;
  final String displayName;
  final String desc;
  final IconData icon;
  final Color color;
  final Color bg;

  const CategoryMeta({
    required this.name,
    required this.displayName,
    required this.desc,
    required this.icon,
    required this.color,
    required this.bg,
  });
}

/// Diccionario central de categorías.
const Map<String, CategoryMeta> kCategoryMeta = {
  'salud': CategoryMeta(
    name: 'Salud',
    displayName: 'Salud y Bienestar',
    desc: 'Farmacias y centros médicos.',
    icon: Icons.monitor_heart_outlined,
    color: PhColors.red,
    bg: PhColors.redSoft,
  ),
  'deporte': CategoryMeta(
    name: 'Deporte',
    displayName: 'Deportes',
    desc: 'Actividades y artículos deportivos.',
    icon: Icons.directions_bike,
    color: PhColors.green,
    bg: PhColors.greenSoft,
  ),
  'comercios': CategoryMeta(
    name: 'Comercios',
    displayName: 'Convenios Locales',
    desc: 'Descuentos en comercios generales.',
    icon: Icons.store_outlined,
    color: PhColors.orange,
    bg: PhColors.orangeSoft,
  ),
  'gastronomia': CategoryMeta(
    name: 'Gastronomía',
    displayName: 'Gastronomía',
    desc: 'Restaurantes y heladerías.',
    icon: Icons.restaurant,
    color: PhColors.orange,
    bg: PhColors.orangeSoft,
  ),
  'mascotas': CategoryMeta(
    name: 'Mascotas',
    displayName: 'Mascotas',
    desc: 'Veterinarias y alimentos.',
    icon: Icons.pets,
    color: PhColors.red,
    bg: PhColors.redSoft,
  ),
  'servicios': CategoryMeta(
    name: 'Servicios',
    displayName: 'Servicios',
    desc: 'Funerarias y otros servicios.',
    icon: Icons.church_outlined,
    color: PhColors.blue,
    bg: PhColors.blueSoft,
  ),
};

/// Helper para obtener metadatos con un fallback.
CategoryMeta getCategoryMeta(String? category) {
  return kCategoryMeta[category] ??
      const CategoryMeta(
        name: 'General',
        displayName: 'General',
        desc: 'Beneficios disponibles.',
        icon: Icons.confirmation_number_outlined,
        color: PhColors.blue,
        bg: PhColors.blueSoft,
      );
}
