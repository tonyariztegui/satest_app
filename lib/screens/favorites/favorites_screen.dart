import 'package:flutter/material.dart';
import 'package:satest_app/widgets/common_widgets/bottom_navigation_bar.dart'; // Assurez-vous que ce chemin est correct
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesScreen extends StatefulWidget {
  final String? username; // Variable pour vérifier si l'utilisateur est connecté

  const FavoritesScreen({super.key, this.username});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  // Liste de produits favoris (mock data)
  List<Map<String, dynamic>> products = [
    {
      'image': 'https://via.placeholder.com/150', // Remplacez par une vraie URL d'image
      'name': 'T-Shirt',
      'price': 20.00,
      'category': 'Women',
    },
    {
      'image': 'https://via.placeholder.com/150', // Remplacez par une vraie URL d'image
      'name': 'Sneakers',
      'price': 50.00,
      'category': 'Men',
    },
  ];

  // Set pour gérer les produits likés
  Set<int> likedProductIds = {};

  @override
  void initState() {
    super.initState();
    _loadLikedProducts();
  }

  // Charger les produits likés depuis SharedPreferences
  void _loadLikedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      likedProductIds = prefs.getStringList('likedProducts')?.map(int.parse).toSet() ?? {};
    });
  }

  // Sauvegarder les produits likés dans SharedPreferences
  void _saveLikedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('likedProducts', likedProductIds.map((id) => id.toString()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        automaticallyImplyLeading: false, // Retire le bouton "Back"
      ),
      body: Column(
        children: [
          // Affichage du nombre d'articles favoris
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Liked Items (${likedProductIds.length})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          // Affichage en grille des produits
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75, // Ajuste la hauteur pour les boutons
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductTile(products[index], index);
              },
            ),
          ),
        ],
      ),
      // Utilisation du BottomNavBar avec gestion du currentIndex
      bottomNavigationBar: BottomNavBar(
        username: widget.username,
        currentIndex: 2, // L'index de la page des favoris est 2
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home', arguments: widget.username);
              break;
            case 1:
              Navigator.pushNamed(context, '/search');
              break;
            case 2:
              // Nous sommes déjà sur la page des favoris, pas d'action nécessaire
              break;
            case 3:
              Navigator.pushNamed(context, '/basket');
              break;
            case 4:
              if (widget.username != null) {
                Navigator.pushNamed(context, '/profile', arguments: widget.username);
              } else {
                Navigator.pushNamed(context, '/sign_in');
              }
              break;
          }
        },
      ),
    );
  }

  // Construction de la tuile de produit
  Widget _buildProductTile(Map<String, dynamic> product, int index) {
    final isLiked = likedProductIds.contains(index); // Vérifie si le produit est liké

    return Card(
      elevation: 5,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Image.network(
                  product['image'],
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product['name'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '€${product['price']}',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
              ),
            ],
          ),
          // Icône pour liker/déliker un produit
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                color: isLiked ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  if (isLiked) {
                    likedProductIds.remove(index);
                  } else {
                    likedProductIds.add(index);
                  }
                  _saveLikedProducts(); // Sauvegarde après modification
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
