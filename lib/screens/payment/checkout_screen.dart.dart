import 'package:flutter/material.dart';

class CheckoutScreen extends StatelessWidget {
  final String? username;
  final double total;

  const CheckoutScreen({super.key, this.username, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username != null ? 'Welcome, $username' : 'Welcome, Guest',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Total Amount: €${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logique de traitement du paiement
                // Par exemple, vous pouvez faire un appel à une API de paiement ici
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment processed successfully!')),
                );
                Navigator.popUntil(context, ModalRoute.withName('/home')); // Retour à la page d'accueil après le paiement
              },
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
