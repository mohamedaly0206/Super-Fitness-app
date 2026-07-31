import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_fitness_app/core/resources/app_svg.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_back_botton.dart';
import 'package:super_fitness_app/modules/smart_coach/domain/entities/conversation.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Conversation? conversation;
  final double scrollOffset;

  const ChatAppBar({super.key, this.conversation, required this.scrollOffset});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final title = _getTitle();
    final blur = (scrollOffset / 8).clamp(0.0, 18.0);
    final opacity = (scrollOffset / 120).clamp(0.0, .35);
    final titleSize = scrollOffset > 40 ? 20.0 : 24.0;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          color: Colors.black.withValues(alpha: opacity),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: kToolbarHeight,
              child: Row(
                children: [
                  const AppSizedBox(width: 18),
                  const CustomBackBotton(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 180),
                        curve: Curves.easeOut,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                        ),
                        child: Text(
                          title,
                          style: getExtraBoldStyle(
                            context: context,
                            color: AppColors.textPrimary,
                            fontSize: 22,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ),

                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Scaffold.maybeOf(context)?.openEndDrawer();
                        },
                        child: SvgPicture.asset(AppSvg.menu, width: 22)
                            .animate(target: scrollOffset > 20 ? 1 : 0)
                            .fade(begin: .8, end: 1, duration: 180.ms)
                            .scale(
                              begin: const Offset(.95, .95),
                              end: const Offset(1, 1),
                              duration: 180.ms,
                            ),
                      );
                    },
                  ),

                  const AppSizedBox(width: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getTitle() {
    final value = conversation?.title.trim();

    if (value == null || value.isEmpty || value.toLowerCase() == 'no title') {
      return 'Smart Coach';
    }

    return value;
  }
}
