import 'package:flutter/material.dart';

class ReturnsScreen extends StatelessWidget {
  final List<String> returns = [];  // Empty list for demo purpose

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Returns'),
      ),
      body: returns.isEmpty
          ? Center(child: Text('No returns have been made.'))
          : ListView.builder(
              itemCount: returns.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Return ${returns[index]}'),
                  subtitle: Text('Details of return ${returns[index]}'),
                );
              },
            ),
    );
  }
}
