import 'package:super_fitness_app/core/network/model/user_entity.dart';

abstract class ProfileRepo {
  Future<UserEntity> getProfile();
}