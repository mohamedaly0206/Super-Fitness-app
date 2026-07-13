import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';
import 'package:super_fitness_app/core/theme/app_text_style.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/resources/app_strings.dart';
import 'package:super_fitness_app/core/theme/font_size_manager.dart';
import 'package:super_fitness_app/core/widgets/app_error_widget.dart';
import 'package:super_fitness_app/core/widgets/app_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/app_shimmer.dart';
import 'package:super_fitness_app/core/widgets/button_loading_widget.dart';
import 'package:super_fitness_app/core/widgets/button_with_prefix.dart';
import 'package:super_fitness_app/core/widgets/custom_appbar.dart';
import 'package:super_fitness_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:super_fitness_app/core/widgets/custom_scaffold.dart';
import 'package:super_fitness_app/core/widgets/custom_snack_bar.dart';
import 'package:super_fitness_app/core/widgets/custom_text_field.dart';
import 'package:super_fitness_app/core/widgets/primary_button.dart';
import 'package:super_fitness_app/core/widgets/shimmer_loading_widget.dart';

class UIShowcasePage extends StatefulWidget {
  const UIShowcasePage({super.key});

  @override
  State<UIShowcasePage> createState() => _UIShowcasePageState();
}

class _UIShowcasePageState extends State<UIShowcasePage> {
  int _selectedNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      background: Backgrounds.login,
      appBar: const CustomAppBar(
        title: AppStrings.uiShowcase,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle(context, 'Colors — Grey Scale'),
            _buildGreyScale(),

            _sectionTitle(context, 'Colors — Red Scale'),
            _buildRedScale(),

            _sectionTitle(context, 'Text Styles (BalooThambi2)'),
            _buildTextStyles(context),

            _sectionTitle(context, 'Primary Button'),
            PrimaryButton(text: 'Get Started', onTap: () {}),

            const SizedBox(height: AppSize.s16),

            _sectionTitle(context, 'Button With Prefix'),
            ButtonWithPrefix(
              text: 'Continue with Google',
              onTap: () {},
              prefixIcon: const Icon(
                Icons.g_mobiledata,
                color: AppColors.textWhite,
                size: AppSize.s24,
              ),
            ),

            const SizedBox(height: AppSize.s16),

            _sectionTitle(context, 'Button Loading (Shimmer)'),
            const ButtonLoadingWidget(),

            const SizedBox(height: AppSize.s16),

            _sectionTitle(context, 'Text Fields'),
            const CustomTextField(
              hintText: 'Email',
              prefixIcon: Icon(Icons.mail_outline),
            ),
            const SizedBox(height: AppSize.s12),
            const CustomTextField(
              hintText: 'Password',
              isPassword: true,
              prefixIcon: Icon(Icons.lock_outline),
            ),
            const SizedBox(height: AppSize.s12),
            const CustomTextField(
              hintText: 'Search...',
              prefixIcon: Icon(Icons.search),
            ),

            const SizedBox(height: AppSize.s16),

            _sectionTitle(context, 'Loading Widget'),
            const AppLoadingWidget(),

            const SizedBox(height: AppSize.s16),

            _sectionTitle(context, 'Shimmer Widgets'),
            AppShimmer(
              child: Container(
                width: double.infinity,
                height: AppSize.s60,
                decoration: BoxDecoration(
                  color: AppColors.grey600,
                  borderRadius: BorderRadius.circular(AppSize.borderRadiusCard),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s8),
            const ImageShimmer(
              width: AppSize.s120,
              height: AppSize.s120,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.borderRadiusCard),
              ),
            ),

            const SizedBox(height: AppSize.s16),

            _sectionTitle(context, 'Error Widget'),
            AppErrorWidget(
              errorMessage: 'Something went wrong. Please try again.',
              onRetry: () {},
            ),

            const SizedBox(height: AppSize.s16),

            _sectionTitle(context, 'SnackBar Triggers'),
            Wrap(
              spacing: AppSize.s8,
              runSpacing: AppSize.s8,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      CustomSnackBar.success(context, 'Operation completed!'),
                  child: const Text('Success'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.error,
                  ),
                  onPressed: () =>
                      CustomSnackBar.error(context, 'Something failed!'),
                  child: const Text('Error'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.grey900,
                  ),
                  onPressed: () => CustomSnackBar.info(context, 'Info message'),
                  child: const Text('Info'),
                ),
              ],
            ),

            const SizedBox(height: AppSize.s16),

            _sectionTitle(context, 'Bottom Navigation Bar'),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.borderRadiusLarge),
              child: Container(
                color: AppColors.navBarBackground,
                child: CustomBottomNavBar(
                  selectedIndex: _selectedNavIndex,
                  onItemTapped: (index) {
                    setState(() => _selectedNavIndex = index);
                  },
                ),
              ),
            ),

            const SizedBox(height: AppSize.s48),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: AppPadding.p12,
        top: AppPadding.p8,
      ),
      child: Text(
        title,
        style: getBoldStyle(
          context: context,
          fontSize: FontSizeManager.s18,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildGreyScale() {
    const greys = [
      ('grey0', AppColors.grey0),
      ('grey1', AppColors.grey1),
      ('grey2', AppColors.grey2),
      ('grey3', AppColors.grey3),
      ('grey4', AppColors.grey4),
      ('grey5', AppColors.grey5),
      ('grey6', AppColors.grey6),
      ('grey7', AppColors.grey7),
      ('grey8', AppColors.grey8),
      ('grey9', AppColors.grey9),
      ('grey10', AppColors.grey10),
      ('grey11', AppColors.grey11),
      ('grey12', AppColors.grey12),
    ];
    return _buildColorRow(greys);
  }

  Widget _buildRedScale() {
    const reds = [
      ('red0', AppColors.red0),
      ('red1', AppColors.red1),
      ('red2', AppColors.red2),
      ('red3', AppColors.red3),
      ('red4', AppColors.red4),
      ('red5', AppColors.red5),
      ('red6', AppColors.red6),
      ('red7', AppColors.red7),
      ('red8', AppColors.red8),
      ('primary', AppColors.primary),
      ('red10', AppColors.red10),
      ('red11', AppColors.red11),
      ('red12', AppColors.red12),
      ('red13', AppColors.red13),
      ('red14', AppColors.red14),
      ('red15', AppColors.red15),
      ('red16', AppColors.red16),
      ('red17', AppColors.red17),
      ('red18', AppColors.red18),
    ];
    return _buildColorRow(reds);
  }

  Widget _buildColorRow(List<(String, Color)> colors) {
    return Wrap(
      spacing: AppSize.s8,
      runSpacing: AppSize.s8,
      children: colors.map((c) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSize.s48,
              height: AppSize.s48,
              decoration: BoxDecoration(
                color: c.$2,
                borderRadius: BorderRadius.circular(AppSize.borderRadiusSmall),
                border: Border.all(
                  color: AppColors.grey5,
                  width: AppSize.borderHairline,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s4),
            Text(
              c.$1,
              style: const TextStyle(
                fontSize: FontSizeManager.s9,
                color: AppColors.iconInactive,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildTextStyles(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display Large — 57px',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        Text(
          'Display Medium — 45px',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        Text(
          'Display Small — 36px',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        const SizedBox(height: AppSize.s8),
        Text(
          'Headline Large — 32px',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          'Headline Medium — 28px',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          'Headline Small — 24px',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: AppSize.s8),
        Text(
          'Title Large — 22px',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'Title Medium — 16px',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(
          'Title Small — 14px',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: AppSize.s8),
        Text('Body Large — 16px', style: Theme.of(context).textTheme.bodyLarge),
        Text(
          'Body Medium — 14px',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text('Body Small — 12px', style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppSize.s8),
        Text(
          'Label Large — 14px bold',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Text(
          'Label Medium — 12px',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Text(
          'Label Small — 11px',
          style: Theme.of(context).textTheme.labelSmall,
        ),
        const SizedBox(height: AppSize.s12),
        Text(
          'Helper styles — Light',
          style: getLightStyle(
            context: context,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          'Helper styles — Regular',
          style: getRegularStyle(
            context: context,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          'Helper styles — Medium',
          style: getMediumStyle(
            context: context,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          'Helper styles — SemiBold',
          style: getSemiBoldStyle(
            context: context,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          'Helper styles — Bold',
          style: getBoldStyle(context: context, color: AppColors.textSecondary),
        ),
        Text('Underlined text', style: getTextWithLine(context: context)),
      ],
    );
  }
}
