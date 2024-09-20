import 'package:flutter/material.dart';
import 'package:satest_app/widgets/product_widgets/product_tile.dart'; // Utilisation de ProductTile
import 'package:satest_app/widgets/common_widgets/custom_button.dart'; // Pour le bouton "Checkout"
import 'package:satest_app/widgets/common_widgets/bottom_navigation_bar.dart'; // Assurez-vous que ce chemin est correct
import 'package:satest_app/screens/payment/checkout_screen.dart.dart'; // Assurez-vous d'importer la page de paiement

class BasketScreen extends StatefulWidget {
  final String? username; // Vérification si l'utilisateur est connecté

  const BasketScreen({super.key, this.username});

  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  // Données fictives pour les articles du panier
  List<Map<String, dynamic>> basketItems = [
    {
      'name': 'T-Shirt',
      'price': 20.00,
      'image': 'https://via.placeholder.com/150', // Remplacez par une vraie URL d'image
      'quantity': 1,
    },
    {
      'name': 'Trousers',
      'price': 40.00,
      'image': 'https://via.placeholder.com/150', // Remplacez par une vraie URL d'image
      'quantity': 2,
    },
  ];

  // Calcul du total des articles dans le panier
  double _calculateTotal() {
    return basketItems.fold(0, (total, item) => total + item['price'] * item['quantity']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
        automaticallyImplyLeading: false, // Retire le bouton "Back"
      ),
      body: Column(
        children: [
          Expanded(
            child: basketItems.isEmpty
                ? const Center(
                    child: Text(
                      'Your basket is empty.',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: basketItems.length,
                    itemBuilder: (context, index) {
                      final item = basketItems[index];
                      return ProductTile(
                        imageUrl: item['image'],
                        title: item['name'],
                        price: '€${item['price']}',
                        quantity: item['quantity'],
                        onQuantityChange: (newQuantity) {
                          setState(() {
                            item['quantity'] = newQuantity;
                          });
                        },
                        onDeletePressed: () {
                          setState(() {
                            basketItems.removeAt(index);
                          });
                        },
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Delivery:', style: TextStyle(fontSize: 18)),
                    Text('€0.00', style: TextStyle(fontSize: 18)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(
                      '€${_calculateTotal().toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  icon: Icons.shopping_cart,
                  text: 'Checkout',
                  onPressed: basketItems.isEmpty
                      ? null // Désactive le bouton si le panier est vide
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                username: widget.username,
                                total: _calculateTotal(),
                              ),
                            ),
                          );
                        },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        username: widget.username,
        currentIndex: 3, // L'index de la page Basket est 3
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home', arguments: widget.username);
              break;
            case 1:
              Navigator.pushNamed(context, '/search');
              break;
            case 2:
              Navigator.pushNamed(context, '/favorites');
              break;
            case 3:
              // Nous sommes déjà sur la page Basket, aucune action nécessaire
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
}
