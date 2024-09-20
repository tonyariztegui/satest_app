import 'package:dio/dio.dart';

class AuthService {
  static const String _baseUrl = 'http://10.11.11.158:1337/api';  // Vérifiez si l'URL de base correspond à votre API

  final Dio _dio = Dio();

  // Connexion utilisateur
  Future<Map<String, dynamic>?> signIn(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/login', // Endpoint à vérifier si c'est bien /login pour Strapi ou un autre endpoint
        data: {
          'identifier': email,  // Si l'API requiert 'email' ou un autre champ comme 'username' à la place de 'identifier'
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return response.data;  // Les données retournées par l'API doivent correspondre au format attendu, par exemple un JWT ou un user ID
      } else {
        throw Exception('Login failed with status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('DioError: ${e.response?.statusCode} -> ${e.response?.data}');
        throw Exception('Failed to login: ${e.response?.statusCode}');
      } else {
        throw Exception('Failed to login: $e');
      }
    }
  }
}
