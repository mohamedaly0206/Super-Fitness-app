import 'package:flutter/material.dart';
import 'package:super_fitness_app/config/routes/routes.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key, required this.route});
  final String route;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.map_outlined,
              size: AppSize.s64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: AppSize.s16),
            Text(
              AppStrings.routeNotFound,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSize.s8),
            Text(route, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: AppSize.s24),
            FilledButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.splash,
                (_) => false,
              ),
              child: const Text(AppStrings.goHome),
            ),
          ],
        ),
      ),
    );
  }
}
