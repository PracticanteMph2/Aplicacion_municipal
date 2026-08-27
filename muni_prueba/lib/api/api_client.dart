import 'dart:convert';
import 'dart:io';

/// Cliente HTTP central, equivalente a lib/api.ts del proyecto original.
///
/// NO se usa por defecto: la app arranca con datos mock en memoria (AppState),
/// igual que el proyecto original (que no tenía backend). Cuando tengas una API
/// real (por ejemplo el Express que describían los scripts), define
/// [ApiClient.baseUrl] y reemplaza los métodos de AppState por llamadas a estos
/// helpers.
class ApiError implements Exception {
  final String message;
  final int status;
  ApiError(this.message, this.status);
  @override
  String toString() => 'ApiError($status): $message';
}

class ApiClient {
  /// Ej: "http://10.0.2.2:4000" para el emulador Android.
  static String baseUrl = const String.fromEnvironment('API_URL', defaultValue: '');

  static String? _token;
  static void setToken(String? token) => _token = token;

  static final HttpClient _client = HttpClient();

  static Future<Map<String, dynamic>> request(
      String path, {
        String method = 'GET',
        Object? body,
        bool auth = true,
      }) async {
    final uri = Uri.parse('$baseUrl/api$path');
    HttpClientRequest req;
    try {
      req = await _client.openUrl(method, uri);
    } catch (_) {
      throw ApiError('Sin conexión con el servidor. Revisa tu red e intenta nuevamente.', 0);
    }

    req.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
    if (auth && _token != null) {
      req.headers.set(HttpHeaders.authorizationHeader, 'Bearer $_token');
    }
    if (body != null) {
      req.add(utf8.encode(jsonEncode(body)));
    }

    final res = await req.close();
    final text = await res.transform(utf8.decoder).join();
    Map<String, dynamic> data = {};
    if (text.isNotEmpty) {
      try {
        data = jsonDecode(text) as Map<String, dynamic>;
      } catch (_) {
        data = {};
      }
    }

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ApiError(
        (data['error'] as String?) ?? 'Ocurrió un error. Intenta nuevamente.',
        res.statusCode,
      );
    }
    return data;
  }
}
