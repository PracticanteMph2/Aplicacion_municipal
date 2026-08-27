import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../data/mock_data.dart';

/// Estado central de la app.
class AppState extends ChangeNotifier {
  final SessionUser _user = mockUser();
  final CardInfo _card = mockCard();
  final List<Benefit> _benefits = mockBenefits();
  final List<Redemption> _redemptions = mockRedemptions();
  final List<AppNotification> _notifications = mockNotifications();

  bool _authenticated = false;
  bool _initialized = false;
  bool get initialized => _initialized;

  Future<void> init() async{
    final prefs = await SharedPreferences.getInstance();
    final String? rutGuardado = prefs.getString('user_rut');

    if(rutGuardado != null){
      ///busca el rut en la base de datos
      _authenticated = true;
      ///se cargan los datos desde la base
    }

    _initialized = true;
    notifyListeners();
  }

  Future<void> login({required String rut, required String birthdate}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_rut', rut);

    _authenticated = true;
    notifyListeners();
  }

  Future<void> logout() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_rut');

    _authenticated = false;
    notifyListeners();
  }

  // ---- Sesión ----
  SessionUser get user => _user;
  bool get authenticated => _authenticated;


  void updateMe({String? phone, String? email, String? address}) {
    if (phone != null) _user.phone = phone;
    if (email != null) _user.email = email;
    if (address != null) _user.address = address;
    notifyListeners();
  }

  // ---- Tarjeta ----
  CardInfo get card => _card;

  // ---- Beneficios ----
  List<Benefit> get benefits => List.unmodifiable(_benefits);
  List<Benefit> get assignedBenefits =>
      _benefits.where((b) => b.assigned).toList();

  List<Benefit> benefitsByCategory(String category) =>
      _benefits.where((b) => b.category == category).toList();

  void toggleFavorite(String id) {
    final b = _benefits.firstWhere((x) => x.id == id);
    b.favorite = !b.favorite;
    notifyListeners();
  }

  void activateBenefit(String id) {
    final b = _benefits.firstWhere((x) => x.id == id);
    b.assigned = true;
    notifyListeners();
  }

  // ---- Canjes ----
  List<Redemption> get redemptions => List.unmodifiable(_redemptions);
  int get redemptionsTotal => _redemptions.length;

  /// Registra un nuevo uso de beneficio y devuelve el código generado.
  String registerRedemption(Benefit b, Offer offer) {
    final now = DateTime.now();
    final chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final randomCode = 'PH-${List.generate(6, (i) => chars[(now.microsecond + i) % chars.length]).join()}';

    String two(int n) => n.toString().padLeft(2, '0');
    final iso =
        '${now.year}-${two(now.month)}-${two(now.day)} ${two(now.hour)}:${two(now.minute)}:${two(now.second)}';

    _redemptions.insert(
      0,
      Redemption(
        id: 'r${now.millisecondsSinceEpoch}',
        benefitId: b.id,
        offerId: offer.id,
        title: b.title,
        discount: offer.title,
        merchant: b.merchant ?? b.title,
        address: b.address,
        code: randomCode,
        redeemedAt: iso,
      ),
    );

    _notifications.insert(
      0,
      AppNotification(
        id: 'n${now.millisecondsSinceEpoch}',
        type: 'canje',
        title: 'Canje registrado con éxito',
        body: 'Has usado: ${offer.title} en ${b.title}.',
        read: false,
        createdAt: iso,
      ),
    );

    notifyListeners();
    return randomCode;
  }
  // ---- Notificaciones ----
  List<AppNotification> get notifications => List.unmodifiable(_notifications);
  int get unread => _notifications.where((n) => !n.read).length;

  void markNotificationRead(String id) {
    final n = _notifications.firstWhere((x) => x.id == id);
    n.read = true;
    notifyListeners();
  }

  void markAllNotificationsRead() {
    for (final n in _notifications) {
      n.read = true;
    }
    notifyListeners();
  }
}
