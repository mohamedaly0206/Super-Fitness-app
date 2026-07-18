import 'package:flutter/material.dart';

class DummyLoginView extends StatelessWidget {
  const DummyLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Center(
        child: Text('Dummy Login View'),
      ),
    );
  }
}