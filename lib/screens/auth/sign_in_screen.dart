// /lib/screens/auth/sign_in_screen.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:satest_app/services/auth_service.dart';
import 'package:satest_app/widgets/common_widgets/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _authService = AuthService();
  String? _errorMessage;

  Future<void> _signIn(String identifier, String password) async {
    try {
      final result = await _authService.signIn(identifier, password);

      if (result != null) {
        final userId = result['account']['id'];
        final username = result['account']['username'];

        // Sauvegarde de l'ID utilisateur
        await _saveUserId(userId);

        // Rediriger vers la page d'accueil ou une autre page
        Navigator.pushReplacementNamed(context, '/home', arguments: username);
      } else {
        setState(() {
          _errorMessage = 'Login failed. Please check your credentials.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred: $e';
      });
    }
  }

  Future<void> _saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userId', userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SignInForm(onSignIn: _signIn, errorMessage: _errorMessage),
      ),
    );
  }
}
