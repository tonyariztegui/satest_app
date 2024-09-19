import 'package:flutter/material.dart';
import 'package:satest_app/widgets/common_widgets/bottom_navigation_bar.dart'; // Assurez-vous que ce chemin est correct

class FavoritesScreen extends StatefulWidget {
  final String? username; // Ajouter cette variable pour vérifier si l'utilisateur est connecté

  const FavoritesScreen({super.key, this.username});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
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

  Set<int> likedProductIds = {}; // Conserve les ID des produits likés

  @override
  void initState() {
    super.initState();
    // Initialisation des produits likés à partir d'une source de données
    // Par exemple, charger les produits favoris depuis une base de données ou un stockage local
    likedProductIds = {0}; // Exemple: initialisation avec le produit avec index 0
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        automaticallyImplyLeading: false, // Enlève le bouton "Back"
      ),
      body: Column(
        children: [
          // Affichage des articles favoris
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Liked Items (${likedProductIds.length})',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.75, // Ajuster la hauteur pour les boutons
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return _buildProductTile(products[index], index);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(username: widget.username),
    );
  }

  Widget _buildProductTile(Map<String, dynamic> product, int index) {
    final isLiked = likedProductIds.contains(index);

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
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
