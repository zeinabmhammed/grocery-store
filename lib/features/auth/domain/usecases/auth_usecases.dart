import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

// ==================== Login ====================
class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) =>
      repository.login(
        phoneOrEmail: params.phoneOrEmail,
        password: params.password,
      );
}

class LoginParams extends Equatable {
  final String phoneOrEmail;
  final String password;
  const LoginParams({required this.phoneOrEmail, required this.password});

  @override
  List<Object> get props => [phoneOrEmail, password];
}

// ==================== Register ====================
class RegisterUseCase extends UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(RegisterParams params) =>
      repository.register(
        name: params.name,
        mobile: params.mobile,
        email: params.email,
        password: params.password,
        cPassword: params.cPassword,
        profilePhotoPath: params.profilePhotoPath,
        onesignalId: params.onesignalId,
      );
}

class RegisterParams extends Equatable {
  final String name;
  final String mobile;
  final String email;
  final String password;
  final String cPassword;
  final String? profilePhotoPath;
  final String? onesignalId;

  const RegisterParams({
    required this.name,
    required this.mobile,
    required this.email,
    required this.password,
    required this.cPassword,
    this.profilePhotoPath,
    this.onesignalId,
  });

  @override
  List<Object?> get props => [email, mobile];
}

// ==================== Get Profile ====================
class GetProfileUseCase extends UseCase<UserEntity, NoParams> {
  final AuthRepository repository;
  GetProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) =>
      repository.getProfile();
}

// ==================== Update Profile ====================
class UpdateProfileUseCase extends UseCase<UserEntity, UpdateProfileParams> {
  final AuthRepository repository;
  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UpdateProfileParams params) =>
      repository.updateProfile(
        userId: params.userId,
        name: params.name,
        mobile: params.mobile,
        email: params.email,
        profilePhotoPath: params.profilePhotoPath,
      );
}

class UpdateProfileParams extends Equatable {
  final int userId;
  final String name;
  final String mobile;
  final String email;
  final String? profilePhotoPath;

  const UpdateProfileParams({
    required this.userId,
    required this.name,
    required this.mobile,
    required this.email,
    this.profilePhotoPath,
  });

  @override
  List<Object> get props => [userId];
}

// ==================== Delete User ====================
class DeleteUserUseCase extends UseCase<void, int> {
  final AuthRepository repository;
  DeleteUserUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int userId) =>
      repository.deleteUser(userId);
}

// ==================== Change Password ====================
class ChangePasswordUseCase extends UseCase<void, ChangePasswordParams> {
  final AuthRepository repository;
  ChangePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ChangePasswordParams params) =>
      repository.changePassword(
        oldPassword: params.oldPassword,
        newPassword: params.newPassword,
        cPassword: params.cPassword,
      );
}

class ChangePasswordParams extends Equatable {
  final String oldPassword;
  final String newPassword;
  final String cPassword;

  const ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
    required this.cPassword,
  });

  @override
  List<Object> get props => [oldPassword];
}

// ==================== Forget Password ====================
class ForgetPasswordUseCase extends UseCase<String, String> {
  final AuthRepository repository;
  ForgetPasswordUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(String email) =>
      repository.forgetPassword(email);
}

// ==================== Add to Favorite ====================
class AddToFavoriteUseCase extends UseCase<void, int> {
  final AuthRepository repository;
  AddToFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int favoId) =>
      repository.addToFavorite(favoId);
}

// ==================== Contact Us ====================
class ContactUsUseCase extends UseCase<void, ContactUsParams> {
  final AuthRepository repository;
  ContactUsUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ContactUsParams params) =>
      repository.contactUs(
        name: params.name,
        message: params.message,
        mobile: params.mobile,
      );
}

class ContactUsParams extends Equatable {
  final String name;
  final String message;
  final String mobile;

  const ContactUsParams({
    required this.name,
    required this.message,
    required this.mobile,
  });

  @override
  List<Object> get props => [mobile];
}