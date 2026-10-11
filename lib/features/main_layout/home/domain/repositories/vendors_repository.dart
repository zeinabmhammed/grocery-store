import 'package:dartz/dartz.dart';
import 'package:greengrocer/core/errors/failures.dart';
import '../entities/vendor_entity.dart';

abstract class VendorsRepository {
  Future<Either<Failure, List<VendorEntity>>> getVendors({
    required int regionId,
    int? isFreeDelivery,
  });
}