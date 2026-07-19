import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/modules/app_sections/profile/profile_view.dart';
import 'package:super_fitness_app/modules/app_sections/workouts/workouts_view.dart';

import '../../core/widgets/custom_bottom_nav_bar.dart';
import 'chat/chat_view.dart';
import 'home/home_view.dart';

class AppSections extends StatefulWidget {
  final int initialIndex;

  const AppSections({super.key, this.initialIndex = 0});

  @override
  State<AppSections> createState() => _AppSectionsState();
}

class _AppSectionsState extends State<AppSections> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = _normalizeIndex(widget.initialIndex);
  }

  @override
  void didUpdateWidget(covariant AppSections oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      _currentIndex = _normalizeIndex(widget.initialIndex);
    }
  }

  int _normalizeIndex(int index) {
    return index >= 0 && index <= 3 ? index : 0;
  }

  List<_AppSection> get _sections => [
    const _AppSection(label: AppStrings.home, screen: HomeView()),
    const _AppSection(label: AppStrings.chat, screen: ChatView()),
    const _AppSection(label: AppStrings.workout, screen: WorkoutsView()),
    const _AppSection(label: AppStrings.profile, screen: ProfileView()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: _sections.map((section) => section.screen).toList(),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class _AppSection {
  final String label;
  final Widget screen;

  const _AppSection({required this.label, required this.screen});
}
