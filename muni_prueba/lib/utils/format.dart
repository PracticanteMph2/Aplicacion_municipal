/// Utilidades de fecha y tiempo.
library;

const _months = [
  'enero',
  'febrero',
  'marzo',
  'abril',
  'mayo',
  'junio',
  'julio',
  'agosto',
  'septiembre',
  'octubre',
  'noviembre',
  'diciembre',
];

DateTime? _parse(String iso) {
  final v = iso.replaceFirst(' ', 'T');
  return DateTime.tryParse(v);
}

/// "dd/mm/yyyy"
String formatDate(String? iso) {
  if (iso == null || iso.isEmpty) return '';
  final datePart = iso.length >= 10 ? iso.substring(0, 10) : iso;
  final parts = datePart.split('-');
  if (parts.length != 3) return iso;
  return '${parts[2]}/${parts[1]}/${parts[0]}';
}

/// "JULIO DE 2026"
String monthLabel(String iso) {
  final d = _parse(iso);
  if (d == null) return '';
  return '${_months[d.month - 1]} de ${d.year}'.toUpperCase();
}

/// "27 jul 2026 · 03:54 p. m."
String stampLabel(String iso) {
  final d = _parse(iso);
  if (d == null) return iso;
  String two(int n) => n.toString().padLeft(2, '0');
  final day = two(d.day);
  final month = _months[d.month - 1].substring(0, 3);
  final h24 = d.hour;
  final suffix = h24 < 12 ? 'a. m.' : 'p. m.';
  final h12 = two(h24 % 12 == 0 ? 12 : h24 % 12);
  final mins = two(d.minute);
  return '$day $month ${d.year} · $h12:$mins $suffix';
}

/// "Hace 2 h" / "Ayer" / dd/mm
String relativeTime(String? iso) {
  if (iso == null || iso.isEmpty) return '';
  final then = _parse(iso);
  if (then == null) return formatDate(iso);
  final diff = DateTime.now().difference(then);
  final mins = diff.inMinutes;
  if (mins < 1) return 'Recién';
  if (mins < 60) return 'Hace $mins min';
  final hrs = diff.inHours;
  if (hrs < 24) return 'Hace $hrs h';
  final days = diff.inDays;
  if (days == 1) return 'Ayer';
  if (days < 7) return 'Hace $days días';
  return formatDate(iso);
}
