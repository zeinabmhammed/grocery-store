import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/product_entity.dart';

class CartItemEntity extends Equatable {
  final ProductEntity product;
  final int quantity;
  final SubUnit? selectedSubUnit;

  const CartItemEntity({
    required this.product,
    required this.quantity,
    this.selectedSubUnit,
  });

  double get totalPrice {
    if (selectedSubUnit != null) {
      return selectedSubUnit!.subPrice * quantity;
    }
    return product.price * quantity;
  }

  CartItemEntity copyWith({int? quantity, SubUnit? selectedSubUnit}) {
    return CartItemEntity(
      product: product,
      quantity: quantity ?? this.quantity,
      selectedSubUnit: selectedSubUnit ?? this.selectedSubUnit,
    );
  }

  @override
  List<Object?> get props => [product.id, selectedSubUnit];
}
