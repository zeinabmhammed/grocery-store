import '../../domain/entities/order_entity.dart';

class OrderProductModel extends OrderProductEntity {
  const OrderProductModel({
    required super.id,
    required super.name,
    required super.price,
    required super.quantity,
    super.img,
  });

  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      id: json['product_id'] ?? json['id'] ?? 0,
      name: json['name'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      quantity: json['quantity'] ?? 1,
      img: json['img'],
    );
  }
}

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.status,
    required super.totalPrice,
    super.paymentType,
    super.address,
    super.createdAt,
    super.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final List productsList = json['products'] ?? json['order_products'] ?? [];
    final products = productsList
        .map((p) => OrderProductModel.fromJson(p))
        .toList();

    return OrderModel(
      id: json['id'] ?? 0,
      status: json['status'] ?? '',
      totalPrice: double.tryParse(json['order_total_price'].toString()) ?? 0.0,
      paymentType: json['payment_type'],
      address: json['address'],
      createdAt: json['created_at'],
      products: products,
    );
  }
}
