import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  final List<String> orders = [];  // Empty list for demo purpose

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: orders.isEmpty
          ? Center(child: Text('No orders have been placed.'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Order ${orders[index]}'),
                  subtitle: Text('Details of order ${orders[index]}'),
                );
              },
            ),
    );
  }
}
