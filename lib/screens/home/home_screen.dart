import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final String? username;

  HomeScreen({this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: false,  // Disable back button in Home
      ),
      body: Center(
        child: Text(
          username != null ? 'Welcome $username!' : 'Welcome, Sign In?',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: username != null ? Colors.blue : Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30.0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Basket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home', arguments: username);
              break;
            case 1:
              Navigator.pushNamed(context, '/search');
              break;
            case 2:
              Navigator.pushNamed(context, '/favorites');
              break;
            case 3:
              Navigator.pushNamed(context, '/basket');
              break;
            case 4:
              if (username != null) {
                Navigator.pushNamed(context, '/profile', arguments: username);
              } else {
                Navigator.pushNamed(context, '/sign_in');
              }
              break;
          }
        },
      ),
    );
  }
}
