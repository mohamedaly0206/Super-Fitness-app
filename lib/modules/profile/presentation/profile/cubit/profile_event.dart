import 'package:equatable/equatable.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileDataEvent extends ProfileEvent {
  const GetProfileDataEvent();
}
