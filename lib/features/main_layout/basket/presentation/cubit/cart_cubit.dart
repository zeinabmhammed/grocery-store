
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/product_entity.dart';
import '../../domain/entities/cart_item_entity.dart';
import 'cart_state.dart';

// ← هنضيف الـ create order usecase هنا بعدين
// import 'package:greengrocer/features/main_layout/orders/domain/usecases/create_order_usecase.dart';

class CartCubit extends Cubit<CartState> {
  final List<CartItemEntity> _items = [];

  CartCubit() : super(CartInitial());

  List<CartItemEntity> get items => List.unmodifiable(_items);

  // ── إضافة منتج للسلة ──────────────────────────────────────
  void addItem(ProductEntity product, {SubUnit? selectedSubUnit}) {
    final existingIndex = _items.indexWhere(
          (item) =>
      item.product.id == product.id &&
          item.selectedSubUnit == selectedSubUnit,
    );

    if (existingIndex != -1) {
      // منتج موجود → زود الكمية
      _items[existingIndex] = _items[existingIndex].copyWith(
        quantity: _items[existingIndex].quantity + 1,
      );
    } else {
      // منتج جديد
      _items.add(CartItemEntity(
        product: product,
        quantity: 1,
        selectedSubUnit: selectedSubUnit,
      ));
    }
    _emitUpdated();
  }

  // ── زيادة الكمية ──────────────────────────────────────────
  void increaseQuantity(int index) {
    if (index < 0 || index >= _items.length) return;
    _items[index] = _items[index].copyWith(
      quantity: _items[index].quantity + 1,
    );
    _emitUpdated();
  }

  // ── تقليل الكمية ──────────────────────────────────────────
  void decreaseQuantity(int index) {
    if (index < 0 || index >= _items.length) return;
    if (_items[index].quantity <= 1) {
      removeItem(index);
    } else {
      _items[index] = _items[index].copyWith(
        quantity: _items[index].quantity - 1,
      );
      _emitUpdated();
    }
  }

  // ── حذف منتج ──────────────────────────────────────────────
  void removeItem(int index) {
    if (index < 0 || index >= _items.length) return;
    _items.removeAt(index);
    _emitUpdated();
  }

  // ── تفريغ السلة ───────────────────────────────────────────
  void clearCart() {
    _items.clear();
    _emitUpdated();
  }

  void _emitUpdated() => emit(CartUpdated(List.from(_items)));

  // ── إنشاء أوردر ───────────────────────────────────────────
  Future<void> placeOrder({
    required String paymentType,
    required String address,
    required String deliveryTime,
    String couponCode = '',
  }) async {
    final currentState = state;
    if (currentState is! CartUpdated || currentState.items.isEmpty) return;

    emit(CartCheckoutLoading());

    // ← هنا هنعمل الـ API call بعدين لما نضيف الـ create order usecase
    // في الوقت الحالي بنعمل simulate للـ success
    await Future.delayed(const Duration(seconds: 2));

    // TODO: استبدل ده بالـ actual API call
    // final result = await createOrderUseCase(CreateOrderParams(...));
    // result.fold(
    //   (failure) => emit(CartCheckoutError(failure.message)),
    //   (orderId) {
    //     clearCart();
    //     emit(CartCheckoutSuccess(orderId));
    //   },
    // );

    clearCart();
    emit(const CartCheckoutSuccess(0));
  }
}