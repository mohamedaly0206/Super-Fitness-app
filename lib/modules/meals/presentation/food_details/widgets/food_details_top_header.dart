import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/app_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/custom_back_button.dart';
import 'package:super_fitness_app/modules/meals/domain/entities/meal_entity.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_cubit.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_intent.dart';
import 'package:super_fitness_app/modules/meals/presentation/food_details/cubit/food_details_state.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FoodDetailsTopHeader extends StatelessWidget {
  const FoodDetailsTopHeader({super.key, required this.meal});
  final MealEntity meal;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<FoodDetailsCubit>();

    return BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
      builder: (context, state) {
        final isPlaying = state.isPlayingVideo;
        final controller = state.youtubeController;

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Stack(
            children: [
              if (isPlaying && controller != null)
                SizedBox.expand(
                  child: state.isLoading
                      ? const Center(child: AppLoadingWidget())
                      : ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          child: YoutubePlayer(controller: controller),
                        ),
                )
              else
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(meal.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.black.withValues(alpha: 0.4),
                      ),
                      child: Center(
                        child: InkWell(
                          onTap: () {
                            if (meal.youtubeUrl.isNotEmpty) {
                              cubit.handleFoodDetailsIntent(
                                OpenYoutubeVideoIIntent(
                                  videoUrl: meal.youtubeUrl,
                                ),
                              );
                            }
                          },
                          child: Icon(
                            Icons.play_circle_fill,
                            size: 64,
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.9,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              if (!isPlaying)
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
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
                  ),
                ),

              if (!isPlaying)
                const Positioned(top: 60, left: 20, child: CustomBackButton()),

              if (!isPlaying)
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.name,
                        style: getMediumStyle(
                          context: context,
                          color: theme.colorScheme.onPrimary,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        meal.instructions,
                        style: getRegularStyle(
                          context: context,
                          color: theme.colorScheme.onPrimary,
                          fontSize: 16,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
