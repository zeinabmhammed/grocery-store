import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../entities/vendor_entity.dart';
import '../repositories/vendors_repository.dart';

class GetVendorsUseCase extends UseCase<List<VendorEntity>, GetVendorsParams> {
  final VendorsRepository repository;
  GetVendorsUseCase(this.repository);

  @override
  Future<Either<Failure, List<VendorEntity>>> call(GetVendorsParams params) =>
      repository.getVendors(
        regionId: params.regionId,
        isFreeDelivery: params.isFreeDelivery,
      );
}

class GetVendorsParams extends Equatable {
  final int regionId;
  final int? isFreeDelivery;

  const GetVendorsParams({
    required this.regionId,
    this.isFreeDelivery,
  });

  @override
  List<Object?> get props => [regionId, isFreeDelivery];
}