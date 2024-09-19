import 'package:flutter/material.dart';
import 'package:satest_app/widgets/product_widgets/product_tile.dart'; // Utilisation de ProductTile
import 'package:satest_app/widgets/common_widgets/custom_button.dart';// Pour le bouton "Checkout"
import 'package:satest_app/widgets/common_widgets/bottom_navigation_bar.dart'; // Assurez-vous que ce chemin est correct

class BasketScreen extends StatefulWidget {
  final String? username; // Ajouter cette variable pour vérifier si l'utilisateur est connecté

  const BasketScreen({super.key, this.username});

  @override
  _BasketScreenState createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  // Mock data for basket items
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
    double total = 0;
    for (var item in basketItems) {
      total += item['price'] * item['quantity'];
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basket'),
        automaticallyImplyLeading: false, // Enlève le bouton "Back"
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
                    Text('€${_calculateTotal().toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                CustomButton(
                  icon: Icons.shopping_cart, // Ajout d'une icône facultative
                  text: 'Checkout',
                  onPressed: basketItems.isEmpty
                      ? null // Désactive le bouton si le panier est vide
                      : () {
                          Navigator.pushNamed(context, '/checkout');
                        },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(username: widget.username),
    );
  }
}
