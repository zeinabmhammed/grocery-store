import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String token;
  final String? profilePhoto;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.token,
    this.profilePhoto,
  });

  @override
  List<Object?> get props => [id, email, mobile];
}