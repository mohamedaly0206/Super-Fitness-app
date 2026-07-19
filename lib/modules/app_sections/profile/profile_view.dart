import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      background: Backgrounds.profileAndEdit,
      body: SafeArea(
        child: Center(
          child: Text(
            'Profile Screen',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}