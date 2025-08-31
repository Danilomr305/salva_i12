import 'dart:convert';
import 'package:http/http.dart' as http;

class UsuarioRepository {
  Future<Map<String, dynamic>?> usuarioLogin(
      String username, String password) async {
    final url = Uri.parse('https://security.logos.seg.br/login');
    final body = json.encode({
      "username": username,
      "password": password,
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print("Erro no login: $e");
      return null;
    }
  }
}
