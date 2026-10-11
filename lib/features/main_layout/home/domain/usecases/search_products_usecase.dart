import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';

class SearchProductsUseCase extends UseCase<List<ProductEntity>, String> {
  final ProductsRepository repository;
  SearchProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(String keyword) =>
      repository.searchProducts(keyword);
}