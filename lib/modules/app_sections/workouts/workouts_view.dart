import 'package:flutter/cupertino.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';

class WorkoutsView extends StatelessWidget {
  const WorkoutsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      background: Backgrounds.weightAndGoalActivityEdit,
      body: Text('Workouts View'),
    );
  }
}
