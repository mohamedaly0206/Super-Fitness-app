import 'package:flutter/cupertino.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      background: Backgrounds.homeAndSelectDetailsExercise,
      body: Text('Home View'),
    );
  }
}
