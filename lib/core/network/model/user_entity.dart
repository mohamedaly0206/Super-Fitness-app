class UserEntity {
  String? firstName;
  String? lastName;
  String? email;
  String? gender;
  String? phone;
  String? photo;
  String? role;
  List<dynamic>? wishlist;
  String? id;
  List<dynamic>? addresses;
  int? age;
  int? weight;
  int? height;
  String? activityLevel;
  String? goal;

  DateTime? createdAt;

  UserEntity({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phone,
    this.photo,
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
}