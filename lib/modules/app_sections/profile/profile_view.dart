import 'package:flutter/cupertino.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      background: Backgrounds.profileAndEdit,
      body: Text('Profile View'),
    );
  }
}
