import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item_entity.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class CartUpdated extends CartState {
  final List<CartItemEntity> items;
  const CartUpdated(this.items);

  double get subtotal =>
      items.fold(0, (sum, item) => sum + item.totalPrice);

  double get shippingCharges => items.isEmpty ? 0 : 1.5;

  double get total => subtotal + shippingCharges;

  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  @override
  List<Object?> get props => [items];
}

class CartCheckoutLoading extends CartState {}

class CartCheckoutSuccess extends CartState {
  final int orderId;
  const CartCheckoutSuccess(this.orderId);
  @override
  List<Object?> get props => [orderId];
}

class CartCheckoutError extends CartState {
  final String message;
  const CartCheckoutError(this.message);
  @override
  List<Object?> get props => [message];
}