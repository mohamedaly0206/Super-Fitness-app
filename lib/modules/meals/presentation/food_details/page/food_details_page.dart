import 'package:flutter/material.dart';

// TEMPORARY: static placeholder for local testing 

class FoodDetailsPage extends StatelessWidget {
  const FoodDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Details')),
      body: const Center(child: Text('Food Details (Temporary)')),
    );
  }
}
