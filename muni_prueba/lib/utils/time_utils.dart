import '../models/models.dart';

/// Resultado de la verificación de disponibilidad.
class AvailabilityResult {
  final bool isAvailable;
  final String message;

  AvailabilityResult({required this.isAvailable, required this.message});
}

/// Utilidades para el manejo de lógica de tiempo y horarios.
class TimeUtils {
  /// Devuelve el nombre del día en español.
  static String getDayName(int day) {
    switch (day) {
      case 1: return "Lunes";
      case 2: return "Martes";
      case 3: return "Miércoles";
      case 4: return "Jueves";
      case 5: return "Viernes";
      case 6: return "Sábado";
      case 7: return "Domingo";
      default: return "";
    }
  }

  /// Verifica si un beneficio (y opcionalmente una oferta) está disponible actualmente.
  static AvailabilityResult checkAvailability(Benefit b, {Offer? offer}) {
    final now = DateTime.now();
    final today = now.weekday;
    final currentHour = now.hour;

    // 1. LÓGICA DE DISPONIBILIDAD DEL LOCAL
    final merchantResult = _checkMapHours(b.customHours, today, currentHour);
    if (!merchantResult.isAvailable && offer == null) {
      return merchantResult;
    }

    // 2. LÓGICA ESPECÍFICA DE LA OFERTA (Si se proporciona)
    if (offer != null) {
      // A. Verificar días permitidos
      final bool isOfferDayValid = offer.availableDays == null || offer.availableDays!.contains(today);
      if (!isOfferDayValid) {
        final days = offer.availableDays!.map((d) => getDayName(d)).join(", ");
        return AvailabilityResult(
          isAvailable: false,
          message: 'Esta oferta solo está disponible los días: $days.',
        );
      }

      // B. Verificar horarios específicos de la oferta (Si existen)
      if (offer.customHours != null) {
        final offerResult = _checkMapHours(offer.customHours, today, currentHour);
        if (!offerResult.isAvailable) {
          return AvailabilityResult(
            isAvailable: false,
            message: 'Esta oferta tiene un horario especial: ${offerResult.message}',
          );
        }
      }

      // C. Si la oferta no tiene horarios propios, debe respetar los del comercio
      if (!merchantResult.isAvailable) {
        return merchantResult;
      }
    }

    // 3. RESULTADO FINAL
    return AvailabilityResult(
      isAvailable: true,
      message: '¡Disponible ahora!',
    );
  }

  /// Helper para verificar disponibilidad en un mapa de horarios.
  static AvailabilityResult _checkMapHours(Map<int, List<int>>? customHours, int today, int currentHour) {
    if (customHours == null) {
      return AvailabilityResult(isAvailable: true, message: '');
    }

    final yesterday = today == 1 ? 7 : today - 1;
    final hoursToday = customHours[today];
    final hoursYesterday = customHours[yesterday];

    // Revisar jornada de ayer (madrugada)
    if (hoursYesterday != null && hoursYesterday[1] < hoursYesterday[0]) {
      if (currentHour < hoursYesterday[1]) {
        return AvailabilityResult(isAvailable: true, message: '');
      }
    }

    if (hoursToday == null) {
      return AvailabilityResult(isAvailable: false, message: 'No aplica el día de hoy');
    }

    final start = hoursToday[0];
    final end = hoursToday[1];

    if (end > start) {
      if (currentHour >= start && currentHour < end) {
        return AvailabilityResult(isAvailable: true, message: '');
      } else if (currentHour < start) {
        return AvailabilityResult(isAvailable: false, message: 'Inicia hoy a las $start:00 hrs');
      } else {
        return AvailabilityResult(isAvailable: false, message: 'Terminado por el día de hoy');
      }
    } else {
      if (currentHour >= start || currentHour < end) {
        return AvailabilityResult(isAvailable: true, message: '');
      }
    }

    return AvailabilityResult(isAvailable: false, message: 'Cerrado ahora');
  }
}
