import 'package:dio/dio.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/dio_error_handler.dart';
import '../models/vendor_model.dart';

abstract class VendorsRemoteDataSource {
  Future<List<VendorModel>> getVendors({
    required int regionId,
    int? isFreeDelivery,
  });
}

class VendorsRemoteDataSourceImpl implements VendorsRemoteDataSource {
  final Dio dio;
  VendorsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<VendorModel>> getVendors({
    required int regionId,
    int? isFreeDelivery,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.vendors,
        queryParameters: {
          'region_id': regionId,
          if (isFreeDelivery != null)
            'is_free_delivery_charges': isFreeDelivery,
        },
      );
      final List data = response.data['data']['data'] ?? [];
      return data.map((e) => VendorModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }
}