import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_durations.dart';

abstract class PageTransitions {
  static PageRoute<dynamic> fade(Widget page) => PageRouteBuilder<dynamic>(
    pageBuilder: (_, _, _) => page,
    transitionsBuilder: (_, a, _, child) =>
        FadeTransition(opacity: a, child: child),
    transitionDuration: AppDurations.fadeTransition,
  );

  static PageRoute<dynamic> slide(Widget page, {RouteSettings? settings}) =>
      PageRouteBuilder<dynamic>(
        settings: settings,
        pageBuilder: (_, _, _) => page,
        transitionsBuilder: (_, a, _, child) => SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
          child: child,
        ),
        transitionDuration: AppDurations.slideTransition,
      );

  static PageRoute<dynamic> search(Widget page) => PageRouteBuilder<dynamic>(
    pageBuilder: (_, animation, _) => page,
    transitionDuration: AppDurations.searchTransition,
    reverseTransitionDuration: AppDurations.searchReverseTransition,
    transitionsBuilder: (_, animation, _, child) {
      final fade = CurvedAnimation(parent: animation, curve: Curves.easeOut);

      final scale = Tween<double>(
        begin: 0.98,
        end: 1,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));

      return FadeTransition(
        opacity: fade,
        child: ScaleTransition(scale: scale, child: child),
      );
    },
  );
}
