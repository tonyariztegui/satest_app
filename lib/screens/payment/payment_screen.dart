import 'package:flutter/material.dart';
import 'package:satest_app/models/product_model.dart'; // Assurez-vous que ce chemin est correct
import 'package:satest_app/widgets/product_widgets/product_tile.dart';// Assurez-vous que ce chemin est correct

class PaymentScreen extends StatelessWidget {
  final List<ProductModel> orderedProducts;

  const PaymentScreen({super.key, required this.orderedProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paiement")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: orderedProducts.length,
              itemBuilder: (context, index) {
                final product = orderedProducts[index];
                return ProductTile(
                  imageUrl: product.imageUrl,
                  title: product.name,
                  price: product.price.toString(),
                  quantity: product.quantity,
                  isInFavorites: product.isInFavorites,
                  // Ajoutez d'autres callbacks si nécessaire
                );
              },
            ),
          ),
          _buildPaymentButton(),
        ],
      ),
    );
  }

  Widget _buildPaymentButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: () {
          // Logique de paiement
        },
        child: const Text("Payer maintenant"),
      ),
    );
  }
}
