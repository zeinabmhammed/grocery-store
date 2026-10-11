import 'package:dartz/dartz.dart';
import 'package:greengrocer/core/errors/failures.dart';
import '../entities/product_entity.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductEntity>>> getVendorProducts(int vendorId);
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String keyword);
  Future<Either<Failure, List<ProductEntity>>> getCategoryProducts(int categoryId);
}