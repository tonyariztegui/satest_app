import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/create_account_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/sign_in',
      routes: {
        '/sign_in': (context) => SignInScreen(),
        '/create_account': (context) => CreateAccountScreen(),
        '/home': (context) {
          final username = ModalRoute.of(context)?.settings.arguments as String?;
          return HomeScreen(username: username);
        },
        // Add other routes here if needed
      },
    );
  }
}
