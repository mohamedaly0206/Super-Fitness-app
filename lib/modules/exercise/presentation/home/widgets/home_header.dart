import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${context.greeting} Ziad',
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                context.startDay,
                style: TextStyle(
                  fontSize: AppSize.s25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          Icon(Icons.person_2_outlined),
        ],
      ),
    );
  }
}
