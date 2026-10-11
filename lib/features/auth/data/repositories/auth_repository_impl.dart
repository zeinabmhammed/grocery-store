import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserEntity>> login({
    required String phoneOrEmail,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(
        phoneOrEmail: phoneOrEmail,
        password: password,
      );
      return Right(user);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register({
    required String name,
    required String mobile,
    required String email,
    required String password,
    required String cPassword,
    String? profilePhotoPath,
    String? onesignalId,
  }) async {
    try {
      final user = await remoteDataSource.register(
        name: name,
        mobile: mobile,
        email: email,
        password: password,
        cPassword: cPassword,
        profilePhotoPath: profilePhotoPath,
        onesignalId: onesignalId,
      );
      return Right(user);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final user = await remoteDataSource.getProfile();
      return Right(user);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile({
    required int userId,
    required String name,
    required String mobile,
    required String email,
    String? profilePhotoPath,
  }) async {
    try {
      final user = await remoteDataSource.updateProfile(
        userId: userId,
        name: name,
        mobile: mobile,
        email: email,
        profilePhotoPath: profilePhotoPath,
      );
      return Right(user);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(int userId) async {
    try {
      await remoteDataSource.deleteUser(userId);
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({
    required String oldPassword,
    required String newPassword,
    required String cPassword,
  }) async {
    try {
      await remoteDataSource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        cPassword: cPassword,
      );
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, String>> forgetPassword(String email) async {
    try {
      final newPassword = await remoteDataSource.forgetPassword(email);
      return Right(newPassword);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, void>> addToFavorite(int favoId) async {
    try {
      await remoteDataSource.addToFavorite(favoId);
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, void>> contactUs({
    required String name,
    required String message,
    required String mobile,
  }) async {
    try {
      await remoteDataSource.contactUs(
        name: name,
        message: message,
        mobile: mobile,
      );
      return const Right(null);
    } on Failure catch (f) {
      return Left(f);
    }
  }
}