import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/layout/app_padding.dart';
import 'package:super_fitness_app/core/layout/app_size.dart';
import 'package:super_fitness_app/core/localization_constants/exercise_constants.dart';
import 'package:super_fitness_app/core/storage/secure_storage_service.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  String _userName = '';
  String? _profileImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final name = await SecureStorageService.getUserName();
    final image = await SecureStorageService.getProfileImage();
    if (mounted) {
      setState(() {
        _userName = name ?? '';
        _profileImage = image;
      });
    }
  }

  Widget _buildAvatar() {
    if (_profileImage != null && _profileImage!.isNotEmpty) {
      return CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primary,
        backgroundImage: NetworkImage(_profileImage!),
      );
    }
    return const Icon(Icons.person_2_outlined);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${context.greeting} ${_userName.isEmpty ? 'User' : _userName}',
                style: TextStyle(
                  fontSize: AppSize.s20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                context.startDay,
                style: TextStyle(
                  fontSize: AppSize.s25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildAvatar(),
        ],
      ),
    );
  }
}
