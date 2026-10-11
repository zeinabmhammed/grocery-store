import 'package:dartz/dartz.dart';
import 'package:greengrocer/core/errors/failures.dart';
import 'package:greengrocer/core/usecases/usecase.dart';
import '../repositories/orders_repository.dart';

class CancelOrderParams {
  final int orderId;
  final String reason;
  const CancelOrderParams({required this.orderId, required this.reason});
}

class CancelOrderUseCase implements UseCase<bool, CancelOrderParams> {
  final OrdersRepository repository;
  CancelOrderUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CancelOrderParams params) =>
      repository.cancelOrder(
        orderId: params.orderId,
        reason: params.reason,
      );
}