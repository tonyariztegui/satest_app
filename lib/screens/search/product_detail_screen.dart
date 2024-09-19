import 'package:flutter/material.dart';
import 'package:satest_app/widgets/common_widgets/bottom_navigation_bar.dart'; // Assurez-vous que le chemin est correct

class ProductDescriptionScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDescriptionScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Column(
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
      bottomNavigationBar: CustomBottomNavigationBar(), // Ajout de la barre de navigation inférieure
    );
  }
}
