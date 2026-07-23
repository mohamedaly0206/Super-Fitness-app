import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/custom_back_button.dart';

class FoodDetailsTopHeader extends StatelessWidget {
  const FoodDetailsTopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?q=80&w=800&auto=format&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFF1E1E1E).withValues(alpha: 8),
                ],
                stops: const [0.4, 1.0],
              ),
            ),
          ),
          // Back Button & Avatar
          Positioned(top: 50, left: 20, child: CustomBackButton()),
          // Title, Subtitle, and Nutrition Info
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pasta With Meat',
                  style: getMediumStyle(
                    context: context,
                    color: theme.colorScheme.onPrimary,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lorem Ipsum Dolor Sit Amet Consectetur, Tempus Volutpat Ut Nisi Morbi.',
                  style: getRegularStyle(
                    context: context,
                    color: theme.colorScheme.onPrimary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
