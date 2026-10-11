import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/dio_error_handler.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String phoneOrEmail,
    required String password,
  });

  Future<UserModel> register({
    required String name,
    required String mobile,
    required String email,
    required String password,
    required String cPassword,
    String? profilePhotoPath,
    String? onesignalId,
  });

  Future<UserModel> getProfile();

  Future<UserModel> updateProfile({
    required int userId,
    required String name,
    required String mobile,
    required String email,
    String? profilePhotoPath,
  });

  Future<void> deleteUser(int userId);

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String cPassword,
  });

  Future<String> forgetPassword(String email);

  Future<void> addToFavorite(int favoId);

  Future<void> contactUs({
    required String name,
    required String message,
    required String mobile,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserModel> login({
    required String phoneOrEmail,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {
          'phone_email': phoneOrEmail,
          'password': password,
        },
      );
      return UserModel.fromJson(response.data['data'] ?? response.data);
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<UserModel> register({
    required String name,
    required String mobile,
    required String email,
    required String password,
    required String cPassword,
    String? profilePhotoPath,
    String? onesignalId,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'mobile': mobile,
        'email': email,
        'password': password,
        'c_password': cPassword,
        if (profilePhotoPath != null) 'profile_photo_path': profilePhotoPath,
        if (onesignalId != null) 'onesignal_id': onesignalId,
      });
      final response = await dio.post(ApiConstants.register, data: formData);
      return UserModel.fromJson(response.data['data'] ?? response.data);
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<UserModel> getProfile() async {
    try {
      final response = await dio.get(ApiConstants.profile);
      return UserModel.fromJson(response.data['data'] ?? response.data);
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<UserModel> updateProfile({
    required int userId,
    required String name,
    required String mobile,
    required String email,
    String? profilePhotoPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'name': name,
        'mobile': mobile,
        'email': email,
        if (profilePhotoPath != null)
          'profile_photo_path':
          await MultipartFile.fromFile(profilePhotoPath),
      });
      final response = await dio.post(
        '${ApiConstants.updateProfile}/$userId',
        data: formData,
      );
      return UserModel.fromJson(response.data['data'] ?? response.data);
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<void> deleteUser(int userId) async {
    try {
      await dio.post(
        '${ApiConstants.deleteUser}/$userId',
        data: {'_method': 'DELETE'},
      );
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String cPassword,
  }) async {
    try {
      await dio.post(
        ApiConstants.changePassword,
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
          'c_password': cPassword,
        },
      );
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<String> forgetPassword(String email) async {
    try {
      final response = await dio.post(
        ApiConstants.forgetPassword,
        data: {'email': email},
      );
      return response.data['data']['new_password'].toString();
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<void> addToFavorite(int favoId) async {
    try {
      await dio.post(
        ApiConstants.userFavorite,
        data: {'favo_id': favoId},
      );
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<void> contactUs({
    required String name,
    required String message,
    required String mobile,
  }) async {
    try {
      await dio.post(
        ApiConstants.contactUs,
        queryParameters: {
          'name': name,
          'message': message,
          'mobile': mobile,
        },
      );
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }
}