import 'package:flutter/material.dart';
import 'screens/home/home_screen.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/create_account_screen.dart';
import 'screens/basket/basket_screen.dart';
import 'screens/search/search_screen.dart';
import 'screens/favorites/favorites_screen.dart';
import 'screens/search/product_detail_screen.dart';

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
        '/search': (context) {
          final username = ModalRoute.of(context)?.settings.arguments as String?;
          return SearchScreen(username: username);
        },
        '/favorites': (context) {
          final username = ModalRoute.of(context)?.settings.arguments as String?;
          return FavoritesScreen(username: username);
        },
        '/basket': (context) {
          final username = ModalRoute.of(context)?.settings.arguments as String?;
          return BasketScreen(username: username);
        },
        '/product_detail': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
          return ProductDetailsScreen(
            product: args ?? {},
          );
        },
      },
    );
  }
}
