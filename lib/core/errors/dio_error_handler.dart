import 'package:dio/dio.dart';
import 'failures.dart';

class DioErrorHandler {
  static Failure handle(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkFailure('No internet connection');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = _extractMessage(e.response?.data);

        switch (statusCode) {
          case 401:
            return UnauthorizedFailure(message);
          case 404:
            return NotFoundFailure(message);
          case 422:
            return ValidationFailure(message);
          default:
            return ServerFailure(message);
        }

      default:
        return UnknownFailure(e.message ?? 'Something went wrong');
    }
  }

  static String _extractMessage(dynamic data) {
    if (data == null) return 'Server error';
    if (data is Map) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          'Server error';
    }
    return 'Server error';
  }
}