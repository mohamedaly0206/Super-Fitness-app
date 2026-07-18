import 'package:super_fitness_app/core/resources/app_png.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  const OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

const List<OnboardingItem> onboardingItems = [
  OnboardingItem(
    image: AppPng.man1,
    title: 'The Price Of Excellence\nIs Discipline',
    description:
        'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
  ),
  OnboardingItem(
    image: AppPng.man2,
    title: 'Fitness Has Never Been So\nMuch Fun',
    description:
        'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
  ),
  OnboardingItem(
    image: AppPng.man3,
    title: 'NO MORE EXCUSES\nDo It Now',
    description:
        'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
  ),
];
