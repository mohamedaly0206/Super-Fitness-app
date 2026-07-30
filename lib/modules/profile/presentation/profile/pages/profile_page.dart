import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:super_fitness_app/config/dependency_injection/di.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/widgets/app_sizebox.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';

import '../../../../../config/routes/app_router.dart';
import '../../../../../core/layout/app_size.dart';
import '../../../../../core/resources/app_svg.dart';
import '../../../../../core/resources/app_value.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_style.dart';
import '../../../../../core/theme/font_size_manager.dart';
import '../../../data/models/requests/web_view_args.dart';
import '../cubit/profile_cubit.dart';
import '../cubit/profile_intent.dart';
import '../cubit/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_image.dart';
import '../widgets/profile_item_data.dart';
import '../widgets/profile_settings_list_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ProfileCubit>()..doIntent(const GetProfileDataIntent()),
      child: const ProfileViewBody(),
    );
  }
}

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return CustomScaffold(
      background: Backgrounds.profileAndEdit,
      body: SafeArea(
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final user = state.user;
            final bool hasPhoto =
                user?.photo != null && user!.photo!.isNotEmpty;
            final String? photoUrl = user?.photo;
            final String userName =
                '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim();
            final displayName = userName.isEmpty ? 'User' : userName;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const ProfileHeader(),
                  const SizedBox(height: 16),

                  ProfileImage(hasPhoto: hasPhoto, photoUrl: photoUrl),
                  const AppSizedBox(height: 7),

                  Text(
                    state.baseState.isLoading ? 'Loading...' : displayName,
                    style: getBoldStyle(
                      context: context,
                      color: AppColors.textWhite,
                      fontSize: FontSizeManager.s22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
                    child: ProfileSettingsListWidget(
                      items: [
                        ProfileItemData(
                          leadingIcon: SvgPicture.asset(
                            AppSvg.profile,
                            height: AppSize.s22,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: AppStrings.editProfile,
                          onTap: () {},
                        ),
                        ProfileItemData(
                          leadingIcon: SvgPicture.asset(
                            AppSvg.change,
                            height: AppSize.s22,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: AppStrings.changeProfile,
                          onTap: () {},
                        ),
                        ProfileItemData(
                          leadingIcon: SvgPicture.asset(
                            AppSvg.language,
                            height: AppSize.s22,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: '',
                          customTitleWidget: RichText(
                            text: TextSpan(
                              text: AppStrings.selectLanguage + ' (',
                              style: getSemiBoldStyle(
                                context: context,
                                color: AppColors.textWhite,
                                fontSize: AppSize.s16,
                              ),
                              children: [
                                TextSpan(
                                  text: isArabic ? 'العربية' : 'English',
                                  style: getSemiBoldStyle(
                                    context: context,
                                    color: AppColors.primary,
                                    fontSize: AppSize.s16,
                                  ),
                                ),
                                const TextSpan(text: ')'),
                              ],
                            ),
                          ),
                          trailing: SizedBox(
                            width: 40,
                            height: 24,
                            child: Transform.scale(
                              scale: 0.7,
                              alignment: Alignment.centerRight,
                              child: Switch(
                                value: context.locale.languageCode == 'ar',
                                onChanged: (value) async {
                                  await context.setLocale(
                                    value
                                        ? const Locale('ar')
                                        : const Locale('en'),
                                  );
                                },
                              ),
                            ),
                          ),
                          onTap: () {},
                        ),
                        ProfileItemData(
                          leadingIcon: SvgPicture.asset(
                            AppSvg.lockSetting,
                            height: AppSize.s22,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: AppStrings.security,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.webView,
                              arguments: WebViewArgs(
                                title: AppStrings.security,
                                url: AppKeys.security,
                              ),
                            );
                          },
                        ),
                        ProfileItemData(
                          leadingIcon: SvgPicture.asset(
                            AppSvg.securityWarning,
                            height: AppSize.s22,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: AppStrings.privacyPolicy,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.webView,
                              arguments: WebViewArgs(
                                title: AppStrings.privacyPolicy,
                                url: AppKeys.privacyPolicy,
                              ),
                            );
                          },
                        ),
                        ProfileItemData(
                          leadingIcon: SvgPicture.asset(
                            AppSvg.help,
                            height: AppSize.s22,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: AppStrings.help,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.webView,
                              arguments: WebViewArgs(
                                title: AppStrings.help,
                                url: AppKeys.help,
                              ),
                            );
                          },
                        ),
                        ProfileItemData(
                          leadingIcon: SvgPicture.asset(
                            AppSvg.logout,
                            height: AppSize.s22,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          title: AppStrings.logout,
                          textColor: AppColors.primary,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
