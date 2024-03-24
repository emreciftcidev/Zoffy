import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String _baseUrl = 'http://127.0.0.1:5175/api/User';

  static Future<bool> signUpUser(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userData),
    );

    return response.statusCode == 200; // ya da API'nizin başarılı kayıt için döndürdüğü başka bir status kodu
  }
}
