import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/search_products_usecase.dart';
import '../../domain/usecases/get_vendor_products_usecase.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final GetVendorProductsUseCase getVendorProductsUseCase;
  final SearchProductsUseCase searchProductsUseCase;

  ProductsCubit({
    required this.getVendorProductsUseCase,
    required this.searchProductsUseCase,
  }) : super(ProductsInitial());

  Future<void> getVendorProducts(int vendorId) async {
    emit(ProductsLoading());
    final result = await getVendorProductsUseCase(vendorId);
    result.fold(
          (failure) => emit(ProductsError(failure.message)),
          (products) => emit(ProductsSuccess(products)),
    );
  }

  Future<void> searchProducts(String keyword) async {
    if (keyword.isEmpty) return;
    emit(ProductsLoading());
    final result = await searchProductsUseCase(keyword);
    result.fold(
          (failure) => emit(ProductsError(failure.message)),
          (products) => emit(ProductsSuccess(products)),
    );
  }
}