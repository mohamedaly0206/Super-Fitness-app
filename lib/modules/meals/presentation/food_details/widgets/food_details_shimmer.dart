import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/widgets/shimmer_loading_widget.dart';

class FoodDetailsShimmer extends StatelessWidget {
  const FoodDetailsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: const Stack(
                fit: StackFit.expand,
                children: [
                  ImageShimmer(width: double.infinity, height: double.infinity),
                  Positioned(
                    left: AppPadding.p20,
                    right: AppPadding.p20,
                    bottom: AppSize.s20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ImageShimmer(
                          width: 180,
                          height: AppSize.s24,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s8),
                          ),
                        ),
                        SizedBox(height: AppSize.s8),
                        ImageShimmer(
                          width: 240,
                          height: AppSize.s16,
                          borderRadius: BorderRadius.all(
                            Radius.circular(AppSize.s8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(AppPadding.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageShimmer(
                  width: AppSize.s120,
                  height: AppSize.s20,
                  borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
                ),
                SizedBox(height: AppSize.s12),
                _IngredientsListShimmer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IngredientsListShimmer extends StatelessWidget {
  const _IngredientsListShimmer();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: List.generate(
          4,
          (index) => Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ImageShimmer(
                      width: 110,
                      height: AppSize.s16,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSize.s8),
                      ),
                    ),
                    ImageShimmer(
                      width: 60,
                      height: AppSize.s14,
                      borderRadius: BorderRadius.all(
                        Radius.circular(AppSize.s8),
                      ),
                    ),
                  ],
                ),
              ),
              if (index != 3)
                Divider(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1,
                  thickness: 1,
                  indent: 8,
                  endIndent: 8,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
