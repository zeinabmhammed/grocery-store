import 'package:dio/dio.dart';
import 'package:greengrocer/core/constants/api_constants.dart';
import 'package:greengrocer/core/errors/dio_error_handler.dart';
import '../models/order_model.dart';

abstract class OrdersRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<bool> cancelOrder({required int orderId, required String reason});
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  final Dio dio;
  OrdersRemoteDataSourceImpl(this.dio);

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await dio.get('${ApiConstants.userOrders}/t/ar');
      final List data = response.data['data']['data'] ?? [];
      return data.map((e) => OrderModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<bool> cancelOrder({
    required int orderId,
    required String reason,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.cancelOrder,
        data: FormData.fromMap({
          'order_id': orderId,
          'reason': reason,
          'lang': 'ar',
        }),
      );
      return response.data['status'] == true;
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }
}