import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:satest_app/screens/auth/sign_in_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({required this.username});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Supprime les informations de l'utilisateur

    // Redirige vers la page de connexion et vide l'historique de navigation
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => SignInScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: true, // Active le bouton "back" uniquement ici
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, $username', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
