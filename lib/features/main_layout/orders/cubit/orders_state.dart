import 'package:equatable/equatable.dart';
import 'package:greengrocer/features/main_layout/orders/domain/entities/order_entity.dart';

abstract class OrdersState extends Equatable {
  const OrdersState();
  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {}
class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {
  final List<OrderEntity> orders;
  const OrdersSuccess(this.orders);
  @override
  List<Object?> get props => [orders];
}

class OrdersError extends OrdersState {
  final String message;
  const OrdersError(this.message);
  @override
  List<Object?> get props => [message];
}

class CancelOrderLoading extends OrdersState {}
class CancelOrderSuccess extends OrdersState {}

class CancelOrderError extends OrdersState {
  final String message;
  const CancelOrderError(this.message);
  @override
  List<Object?> get props => [message];
}
