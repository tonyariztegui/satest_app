import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'About Us',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Our Story: Shirt Avenue was founded with the idea of making high-quality, eco-friendly clothing accessible to everyone. Our journey started in 2024 with a small collection of shirts, and now we have expanded our product range to cater to both men and women across Europe. Our mission is to provide sustainable fashion with a focus on style and comfort.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Text(
              'Terms and Conditions',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Please read the following terms and conditions carefully before using our website. By accessing or using any part of the site, you agree to be bound by these terms. These terms apply to all users of the site, including but not limited to users who are browsers, vendors, customers, merchants, and contributors of content.',
              style: TextStyle(fontSize: 16),
            ),
            // Add more terms and conditions sections as needed.
            const SizedBox(height: 20),
            Text(
              'Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Your privacy is important to us. We are committed to protecting your personal information and your right to privacy. This privacy policy explains how we collect, use, and protect your information when you visit our site and use our services.',
              style: TextStyle(fontSize: 16),
            ),
            // Add more privacy policy sections as needed.
          ],
        ),
      ),
    );
  }
}
