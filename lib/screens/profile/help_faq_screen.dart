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
          children: [
            // Order related queries section
            ExpansionTile(
              title: Text(
                'Order Related Queries',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text('How can I track my order?'),
                ),
                ListTile(
                  title: Text('What payment methods do you accept?'),
                ),
                ListTile(
                  title: Text('How do I return an item?'),
                ),
                ListTile(
                  title: Text('When will my order arrive?'),
                ),
              ],
            ),
            // Account related queries section
            ExpansionTile(
              title: Text(
                'Account Related Queries',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                ListTile(
                  title: Text('How do I reset my password?'),
                ),
                ListTile(
                  title: Text('How do I update my profile information?'),
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
                ListTile(
                  title: Text('Do you offer international shipping?'),
                ),
                ListTile(
                  title: Text('How can I provide feedback?'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
