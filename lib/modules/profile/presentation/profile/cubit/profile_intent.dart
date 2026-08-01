import 'package:equatable/equatable.dart';

sealed class ProfileIntent extends Equatable {
  const ProfileIntent();

  @override
  List<Object?> get props => [];
}

class GetProfileDataIntent extends ProfileIntent {
  const GetProfileDataIntent();
}
