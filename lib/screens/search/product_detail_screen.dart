import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;
  final String? username; // Ajout de l'utilisateur connecté

  const ProductDetailsScreen({super.key, required this.product, this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
        // Le bouton de retour est inclus par défaut dans l'AppBar
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product['image']),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product['name'],
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '€${product['price']}',
                style: const TextStyle(fontSize: 20, color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Category: ${product['category']}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Brand: ${product['brand']}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
