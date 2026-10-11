import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/products_repository.dart';
import '../datasources/products_remote_datasource.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsRemoteDataSource remoteDataSource;
  ProductsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getVendorProducts(
      int vendorId) async {
    try {
      final products = await remoteDataSource.getVendorProducts(vendorId);
      return Right(products);
    } on Failure catch (f) {
      return Left(f);
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(
      String keyword) async {
    try {
      final products = await remoteDataSource.searchProducts(keyword);
      return Right(products);
    } on Failure catch (f) {
      return Left(f);
    }
  }
  @override
  Future<Either<Failure, List<ProductEntity>>> getCategoryProducts(int categoryId) async {
    try {
      final models = await remoteDataSource.getCategoryProducts(categoryId);
      final entities = models.map((m) => ProductEntity(
        id: m.id,
        name: m.name,
        nameEn: m.nameEn,
        price: m.price,
        image: m.image,           // ← مش img
        imageUrl: m.imageUrl,
        priceAfterDiscount: m.priceAfterDiscount,
        description: m.description,     // ← مش details
        descriptionEn: m.descriptionEn, // ← مش detailsEn
        vendorId: m.vendorId,
        categoryId: m.categoryId,
        categoryName: m.categoryName,
        quantity: m.quantity,
        unit: m.unit,
        subUnits: m.subUnits,
      )).toList();
      return Right(models);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}