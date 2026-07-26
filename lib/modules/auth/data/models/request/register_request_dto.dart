import 'package:json_annotation/json_annotation.dart';
import 'package:super_fitness_app/modules/auth/domain/entities/request/register_request_entity.dart';

part 'register_request_dto.g.dart';

@JsonSerializable()
class RegisterRequestDto {
  @JsonKey(name: "firstName")
  final String firstName;
  @JsonKey(name: "lastName")
  final String lastName;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "password")
  final String password;
  @JsonKey(name: "rePassword")
  final String rePassword;
  @JsonKey(name: "gender")
  final String? gender;
  @JsonKey(name: "height")
  final num? height;
  @JsonKey(name: "weight")
  final num? weight;
  @JsonKey(name: "age")
  final num? age;
  @JsonKey(name: "goal")
  final String? goal;
  @JsonKey(name: "activityLevel")
  final String? activityLevel;

  RegisterRequestDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    this.gender,
    this.height,
    this.weight,
    this.age,
    this.goal,
    this.activityLevel,
  });

  factory RegisterRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterRequestDtoToJson(this);

  factory RegisterRequestDto.fromDomain(RegisterRequestEntity entity) {
    return RegisterRequestDto(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      password: entity.password,
      rePassword: entity.rePassword,
      gender: entity.gender?.name,
      height: entity.height,
      weight: entity.weight,
      age: entity.age,
      goal: entity.goal,
      activityLevel: entity.activityLevel,
    );
  }
}
