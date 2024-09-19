import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.11.11.158:1337',  // URL de votre API Strapi
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  // Méthode pour récupérer les informations du profil utilisateur
  Future<Map<String, dynamic>> fetchUserProfile() async {
    try {
      final response = await _dio.get('/users/me');  // Endpoint pour obtenir le profil utilisateur

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load user profile');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load user profile: ${e.message}');
    }
  }

  // Méthode pour mettre à jour les informations du profil utilisateur
  Future<void> updateUserProfile(Map<String, dynamic> userData) async {
    try {
      final response = await _dio.put('/users/me', data: userData);  // Endpoint pour mettre à jour le profil utilisateur

      if (response.statusCode != 200) {
        throw Exception('Failed to update user profile');
      }
    } on DioException catch (e) {
      throw Exception('Failed to update user profile: ${e.message}');
    }
  }
}
