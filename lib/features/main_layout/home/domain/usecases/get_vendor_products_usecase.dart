import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/products_repository.dart';

class GetVendorProductsUseCase extends UseCase<List<ProductEntity>, int> {
  final ProductsRepository repository;
  GetVendorProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(int vendorId) =>
      repository.getVendorProducts(vendorId);
}