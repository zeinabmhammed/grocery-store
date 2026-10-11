import 'package:dartz/dartz.dart';
import 'package:greengrocer/core/errors/failures.dart';
import 'package:greengrocer/core/usecases/usecase.dart';
import '../entities/order_entity.dart';
import '../repositories/orders_repository.dart';

class GetOrdersUseCase implements UseCase<List<OrderEntity>, NoParams> {
  final OrdersRepository repository;
  GetOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call(NoParams params) =>
      repository.getOrders();
}