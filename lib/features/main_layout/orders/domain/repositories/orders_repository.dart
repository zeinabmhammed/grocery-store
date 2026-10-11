import 'package:dartz/dartz.dart';
import 'package:greengrocer/core/errors/failures.dart';
import '../entities/order_entity.dart';

abstract class OrdersRepository {
  Future<Either<Failure, List<OrderEntity>>> getOrders();
  Future<Either<Failure, bool>> cancelOrder({
    required int orderId,
    required String reason,
  });
}