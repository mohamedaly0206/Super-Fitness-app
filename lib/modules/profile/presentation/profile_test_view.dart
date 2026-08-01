import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';

class DummyProfileView extends StatelessWidget {
  DummyProfileView({super.key});
  final UserEntity user = UserEntity(
    firstName: 'Mohamed',
    lastName: 'Aly',
    email: 'mo7amed3ly77@gmail.com',
    weight: 92,
    goal: 'Lose Weight',
    activityLevel: 'level3',
    photo: "https://fitness.elevateegy.com/uploads/default-profile.png",
  );
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.editProfile, arguments: user);
        },
        child: Text('Edit Profile'),
      ),
    );
  }
}
