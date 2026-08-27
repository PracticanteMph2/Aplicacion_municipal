/// Modelos de datos, equivalentes a los tipos TypeScript del proyecto original
/// (lib/hooks.ts y components/ph/session.tsx).
library;

class SessionUser {
  final String id;
  final String rut;
  final String firstName;
  final String lastName;
  final String fullName;
  final String birthdate;
  String phone;
  String email;
  String address;
  final String comuna;
  final String vecinoId;
  final String status;
  final String validUntil;

  SessionUser({
    required this.id,
    required this.rut,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.birthdate,
    required this.phone,
    required this.email,
    required this.address,
    required this.comuna,
    required this.vecinoId,
    required this.status,
    required this.validUntil,
  });

  factory SessionUser.fromJson(Map<String, dynamic> j) => SessionUser(
    id: j['id'] ?? '',
    rut: j['rut'] ?? '',
    firstName: j['firstName'] ?? '',
    lastName: j['lastName'] ?? '',
    fullName: j['fullName'] ?? '',
    birthdate: j['birthdate'] ?? '',
    phone: j['phone'] ?? '',
    email: j['email'] ?? '',
    address: j['address'] ?? '',
    comuna: j['comuna'] ?? '',
    vecinoId: j['vecinoId'] ?? '',
    status: j['status'] ?? 'activo',
    validUntil: j['validUntil'] ?? '',
  );
}

class Benefit {
  final String id;
  final String category;
  final String title;
  final String provider;
  final String? merchant;
  final String? address;
  final String discount;
  final String description;
  final String icon;
  final String color;
  final String? schedule;
  final List<Offer>? offers;
  final List<String>? conditions;
  final bool isFeatured;
  // Mapa de: Día (1-7) -> [HoraInicio, HoraFin]
  final Map<int, List<int>>? customHours;
  bool assigned;
  bool favorite;
  final String? img;
  final String? logo;

  Benefit({
    required this.id,
    required this.category,
    required this.title,
    required this.provider,
    this.merchant,
    this.address,
    required this.discount,
    required this.description,
    required this.icon,
    required this.color,
    this.schedule,
    this.offers,
    this.conditions,
    this.isFeatured = false,
    this.customHours,
    this.assigned = false,
    this.favorite = false,
    this.img,
    this.logo,
  });
}
///ofertas independientes
class Offer {
  final String id;
  final String title;
  final String description;
  final List<String>? specificConditions;
  final List<int>? availableDays; /// 1=Lunes 7=domingo
  // Mapa de: Día (1-7) -> [HoraInicio, HoraFin] para horarios específicos de la oferta
  final Map<int, List<int>>? customHours;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    this.specificConditions,
    this.availableDays,
    this.customHours,
  });
}

class CardInfo {
  final String vecinoId;
  final String fullName;
  final String status;
  final String validUntil;
  final int activeBenefits;
  final String qrToken;

  CardInfo({
    required this.vecinoId,
    required this.fullName,
    required this.status,
    required this.validUntil,
    required this.activeBenefits,
    required this.qrToken,
  });
}

class Redemption {
  final String id;
  final String? benefitId;
  final String? offerId;
  final String title;
  final String? discount;
  final String? merchant;
  final String? address;
  final String code;
  final String redeemedAt;

  Redemption({
    required this.id,
    this.benefitId,
    this.offerId,
    required this.title,
    this.discount,
    this.merchant,
    this.address,
    required this.code,
    required this.redeemedAt,
  });
}

class AppNotification {
  final String id;
  final String type; // beneficio | canje | info
  final String title;
  final String? body;
  bool read;
  final String createdAt;

  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    this.body,
    this.read = false,
    required this.createdAt,
  });
}

class NewsItem {
  final String id;
  final String title;
  final String? img;
  final String body;

  const NewsItem({
    required this.id,
    required this.title,
    this.img,
    required this.body,
  });
}
