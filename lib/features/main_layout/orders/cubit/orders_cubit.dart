import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/core/usecases/usecase.dart';
import 'package:greengrocer/features/main_layout/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:greengrocer/features/main_layout/orders/domain/usecases/get_orders_usecase.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrdersUseCase getOrdersUseCase;
  final CancelOrderUseCase cancelOrderUseCase;

  OrdersCubit({
    required this.getOrdersUseCase,
    required this.cancelOrderUseCase,
  }) : super(OrdersInitial());

  Future<void> loadOrders() async {
    emit(OrdersLoading());
    final result = await getOrdersUseCase(NoParams());
    result.fold(
          (failure) => emit(OrdersError(failure.message)),
          (orders) => emit(OrdersSuccess(orders)),
    );
  }

  Future<void> cancelOrder({
    required int orderId,
    required String reason,
  }) async {
    emit(CancelOrderLoading());
    final result = await cancelOrderUseCase(
      CancelOrderParams(orderId: orderId, reason: reason),
    );
    result.fold(
          (failure) => emit(CancelOrderError(failure.message)),
          (_) {
        emit(CancelOrderSuccess());
        loadOrders(); // ← يعمل refresh بعد الإلغاء
      },
    );
  }
}
