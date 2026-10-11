import 'package:equatable/equatable.dart';

class OrderProductEntity {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String? img;

  const OrderProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.img,
  });
}

class OrderEntity extends Equatable {
  final int id;
  final String status;
  final double totalPrice;
  final String? paymentType;
  final String? address;
  final String? createdAt;
  final List<OrderProductEntity> products;

  const OrderEntity({
    required this.id,
    required this.status,
    required this.totalPrice,
    this.paymentType,
    this.address,
    this.createdAt,
    this.products = const [],
  });

  @override
  List<Object?> get props => [id];
}