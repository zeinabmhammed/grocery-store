import 'package:dartz/dartz.dart';
import '../../../../../../core/errors/failures.dart';
import '../../domain/entities/vendor_entity.dart';
import '../../domain/repositories/vendors_repository.dart';
import '../datasources/vendors_remote_datasource.dart';

class VendorsRepositoryImpl implements VendorsRepository {
  final VendorsRemoteDataSource remoteDataSource;
  VendorsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<VendorEntity>>> getVendors({
    required int regionId,
    int? isFreeDelivery,
  }) async {
    try {
      final vendors = await remoteDataSource.getVendors(
        regionId: regionId,
        isFreeDelivery: isFreeDelivery,
      );
      return Right(vendors);
    } on Failure catch (f) {
      return Left(f);
    }
  }
}