import 'package:equatable/equatable.dart';
import 'package:super_fitness_app/core/network/model/user_entity.dart';

class RegisterResponseEntity extends Equatable {
  final String? message;
  final UserEntity? user;
  final String? token;

  const RegisterResponseEntity({this.message, this.user, this.token});

  @override
  List<Object?> get props => [message, user];
}
