import 'package:dartz/dartz.dart';
import 'package:greengrocer/core/errors/failures.dart';
import 'package:greengrocer/core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';

class GetCategoryProductsParams {
  final int categoryId;
  const GetCategoryProductsParams({required this.categoryId});
}

class GetCategoryProductsUseCase
    implements UseCase<List<ProductEntity>, GetCategoryProductsParams> {
  final ProductsRepository repository;
  GetCategoryProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(
      GetCategoryProductsParams params) =>
      repository.getCategoryProducts(params.categoryId);
}