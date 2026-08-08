import 'package:super_fitness_app/core/network/model/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable()
class UserDto {
  @JsonKey(name: "firstName")
  final String? firstName;
  @JsonKey(name: "lastName")
  final String? lastName;
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "photo")
  final String? photo;
  @JsonKey(name: "phone")
  final String? phone;
  @JsonKey(name: "role")
  final String? role;
  @JsonKey(name: "wishlist")
  final List<dynamic>? wishlist;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "addresses")
  final List<dynamic>? addresses;
  @JsonKey(name: "age")
  final num? age;
  @JsonKey(name: "weight")
  final num? weight;
  @JsonKey(name: "height")
  final num? height;
  @JsonKey(name: "activityLevel")
  final String? activityLevel;
  @JsonKey(name: "goal")
  final String? goal;
  @JsonKey(name: "createdAt")
  final DateTime? createdAt;

  UserDto({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.photo,
    this.phone,
    this.role,
    this.wishlist,
    this.id,
    this.addresses,
    this.age,
    this.weight,
    this.height,
    this.activityLevel,
    this.goal,
    this.createdAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserEntity toDomain() {
    return UserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      role: role,
      wishlist: wishlist,
      addresses: addresses,
      age: age,
      weight: weight,
      height: height,
      activityLevel: activityLevel,
      goal: goal,
      createdAt: createdAt,
    );
  }
}
