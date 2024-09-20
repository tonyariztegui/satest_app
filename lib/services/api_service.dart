import 'dart:convert';
import 'package:dio/dio.dart';

class ApiService {
  static const String _baseUrl = 'http://10.11.11.158:1337/api';
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  // Authentification (connexion utilisateur)
  Future<Map<String, dynamic>> signIn(String identifier, String password) async {
    try {
      final response = await _dio.post('/auth/local', data: jsonEncode({
        "identifier": identifier,
        "password": password,
      }));
      return response.data;
    } on DioError catch (e) {
      throw Exception('Failed to login: ${e.response?.data}');
    }
  }

  // Création de compte utilisateur
  Future<Map<String, dynamic>> signUp(String username, String email, String password) async {
    try {
      final response = await _dio.post('/auth/local/register', data: jsonEncode({
        "username": username,
        "email": email,
        "password": password,
      }));
      return response.data;
    } on DioError catch (e) {
      throw Exception('Failed to register: ${e.response?.data}');
    }
  }

  // Récupération des informations de profil utilisateur
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    try {
      final response = await _dio.get('/users/me', options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ));
      return response.data;
    } on DioError catch (e) {
      throw Exception('Failed to load profile: ${e.response?.data}');
    }
  }
}
