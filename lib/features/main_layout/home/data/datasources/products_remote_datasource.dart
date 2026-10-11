import 'package:dio/dio.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/errors/dio_error_handler.dart';
import '../models/product_model.dart';

abstract class ProductsRemoteDataSource {
  Future<List<ProductModel>> getVendorProducts(int vendorId);
  Future<List<ProductModel>> searchProducts(String keyword);
  Future<List<ProductModel>> getCategoryProducts(int categoryId);
}

class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSource {
  final Dio dio;
  ProductsRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> getVendorProducts(int vendorId) async {
    try {
      final response = await dio.get(
        ApiConstants.vendorProducts,
        queryParameters: {'vendor_id': vendorId},
      );
      final List data = response.data['data'] ?? response.data ?? [];
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String keyword) async {
    try {
      final response = await dio.get(
        '${ApiConstants.products}/t/ar/0/0/0',
        queryParameters: {'search': keyword},
      );
      final List data = response.data['data']['data'] ?? [];
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }
  @override
  Future<List<ProductModel>> getCategoryProducts(int categoryId) async {
    try {
      final response = await dio.get(
        '${ApiConstants.products}/t/ar/0/$categoryId/0',
      );
      final List data = response.data['data']['data'] ?? [];
      return data.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

}