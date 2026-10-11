import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/features/main_layout/home/domain/usecases/get_category_products_usecase.dart';
import 'category_products_state.dart';

class CategoryProductsCubit extends Cubit<CategoryProductsState> {
  final GetCategoryProductsUseCase getCategoryProductsUseCase;

  CategoryProductsCubit({required this.getCategoryProductsUseCase})
      : super(CategoryProductsInitial());

  Future<void> loadCategoryProducts(int categoryId) async {
    emit(CategoryProductsLoading());
    final result = await getCategoryProductsUseCase(
      GetCategoryProductsParams(categoryId: categoryId),
    );
    result.fold(
          (failure) => emit(CategoryProductsError(failure.message)),
          (products) => emit(CategoryProductsSuccess(products)),
    );
  }
}
