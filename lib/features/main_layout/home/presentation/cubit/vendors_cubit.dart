import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_vendors_usecase.dart';
import 'vendors_state.dart';

class VendorsCubit extends Cubit<VendorsState> {
  final GetVendorsUseCase getVendorsUseCase;
  VendorsCubit(this.getVendorsUseCase) : super(VendorsInitial());

  Future<void> getVendors({
    int regionId = 0,
    int? isFreeDelivery,
  }) async {
    emit(VendorsLoading());

    final result = await getVendorsUseCase(
      GetVendorsParams(
        regionId: regionId,
        isFreeDelivery: isFreeDelivery,
      ),
    );

    result.fold(
          (failure) => emit(VendorsError(failure.message)),
          (vendors) => emit(VendorsSuccess(vendors)),
    );
  }
}