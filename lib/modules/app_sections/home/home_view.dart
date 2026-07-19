import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      body: SafeArea(
        child: Center(
          child: Text(
            'Home Screen',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
