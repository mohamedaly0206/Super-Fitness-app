import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';

class DummyLoginView extends StatelessWidget {
  const DummyLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(background: Backgrounds.login, body:

    Column(
      children: [
        Center(
          child: Text('Dummy Login View'),
        ),
        ElevatedButton(onPressed: (){
          Navigator.pushNamed(context, Routes.register);
        }, child: Text('Register',))
      ],
    ),

    );
  }
}