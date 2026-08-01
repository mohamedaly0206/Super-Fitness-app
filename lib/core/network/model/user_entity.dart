import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final num? age;
  final num? weight;
  final num? height;
  final String? activityLevel;
  final String? goal;
  final String? phone;
  final String? photo;
  final String? role;
  final String? id;
  final DateTime? createdAt;

  const UserEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.phone,
    this.photo,
    this.role,
    this.id,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
    firstName,
    lastName,
    email,
    gender,
    age,
    weight,
    height,
    activityLevel,
    goal,
    phone,
    photo,
    role,
    id,
    createdAt,
  ];
}
