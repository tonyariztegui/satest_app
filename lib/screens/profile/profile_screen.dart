import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:satest_app/screens/auth/sign_in_screen.dart';
import 'package:satest_app/screens/profile/orders_screen.dart';  // Dummy page for orders
import 'package:satest_app/screens/profile/returns_screen.dart';  // Dummy page for returns
import 'package:satest_app/screens/profile/personal_details_screen.dart';  // Page for personal details
import 'package:satest_app/screens/profile/change_password_screen.dart';  // Page to change password
import 'package:satest_app/screens/profile/about_us_screen.dart';  // Page for terms and conditions, FAQ

class ProfileScreen extends StatelessWidget {
  final String username;

  const ProfileScreen({super.key, required this.username});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();  // Supprime les informations de l'utilisateur

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
        title: const Text('Profile'),
        automaticallyImplyLeading: true,  // Active le bouton "back" uniquement ici
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, $username', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            // Orders button
            ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: const Text('Orders'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrdersScreen()),
                );
              },
            ),

            // Returns button
            ListTile(
              leading: const Icon(Icons.assignment_return),
              title: const Text('Returns'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ReturnsScreen()),
                );
              },
            ),

            // Personal details button
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Personal Details'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalDetailsScreen(username: username)),
                );
              },
            ),

            // Change password button
            ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordScreen()),
                );
              },
            ),

            const Divider(),
            const Text('More', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            // About us / Terms and conditions / Help & FAQ buttons
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              },
            ),

            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help & FAQ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              },
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _logout(context),
              child: const Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
