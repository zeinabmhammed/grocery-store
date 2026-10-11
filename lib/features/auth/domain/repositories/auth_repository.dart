import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> login({
    required String phoneOrEmail,
    required String password,
  });

  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String mobile,
    required String email,
    required String password,
    required String cPassword,
    String? profilePhotoPath,
    String? onesignalId,
  });

  Future<Either<Failure, UserEntity>> getProfile();

  Future<Either<Failure, UserEntity>> updateProfile({
    required int userId,
    required String name,
    required String mobile,
    required String email,
    String? profilePhotoPath,
  });

  Future<Either<Failure, void>> deleteUser(int userId);

  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String cPassword,
  });

  Future<Either<Failure, String>> forgetPassword(String email);

  Future<Either<Failure, void>> addToFavorite(int favoId);

  Future<Either<Failure, void>> contactUs({
    required String name,
    required String message,
    required String mobile,
  });
}