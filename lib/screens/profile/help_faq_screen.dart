import 'package:flutter/material.dart';

class HelpFAQScreen extends StatelessWidget {
  const HelpFAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & FAQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            // Order related queries section
            ExpansionTile(
              title: Text(
                'Order Related Queries',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text('Orders'),
                  subtitle: Text('How can I track my order?'),
                ),
                ListTile(
                  title: Text('Payments'),
                  subtitle: Text('What payment methods do you accept?'),
                ),
                ListTile(
                  title: Text('Returns and Refunds'),
                  subtitle: Text('How do I return an item?'),
                ),
                ListTile(
                  title: Text('Delivery'),
                  subtitle: Text('When will my order arrive?'),
                ),
              ],
            ),
            // Non-order related queries section
            ExpansionTile(
              title: Text(
                'Non-Order Related Queries',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text('My Account'),
                  subtitle: Text('How do I reset my password?'),
                ),
                ListTile(
                  title: Text('Profile'),
                  subtitle: Text('How do I update my profile information?'),
                ),
              ],
            ),
            // General FAQ section
            ExpansionTile(
              title: Text(
                'General FAQ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text('What is your return policy?'),
                ),
                ListTile(
                  title: Text('How can I contact customer service?'),
                ),
                ListTile(
                  title: Text('Where are your products made?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
