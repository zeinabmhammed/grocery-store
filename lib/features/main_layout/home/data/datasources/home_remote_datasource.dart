import 'package:dio/dio.dart';
import 'package:greengrocer/core/constants/api_constants.dart';
import 'package:greengrocer/core/errors/dio_error_handler.dart';
import 'package:greengrocer/features/main_layout/home/data/models/product_model.dart';
import '../models/slider_model.dart';
import '../models/category_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<SliderModel>> getSliders();
  Future<List<CategoryModel>> getCategories();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio dio;
  HomeRemoteDataSourceImpl(this.dio);

  @override
  Future<List<SliderModel>> getSliders() async {
    try {
      final response = await dio.get(ApiConstants.slider);
      final List data = response.data['data'];
      return data.map((e) => SliderModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dio.get(ApiConstants.categories);
      final List parentList = response.data['data'];

      List<CategoryModel> subCategories = [];
      for (var parent in parentList) {
        final subCats = parent['sub_cat'] as List? ?? [];

        for (var sub in subCats) {
          final productsList = sub['products'] as List? ?? [];
          print('Category: ${sub['name']} - Products: ${productsList.length}');


          // ← ده الفلتر، شيل الـ categories الفاضية
          if (productsList.isEmpty) continue;

          final products = productsList
              .map((p) => ProductModel.fromJson(p))
              .toList();
          subCategories.add(CategoryModel.fromJson(sub, products: products));
        }
      }
      return subCategories;
    } on DioException catch (e) {
      throw DioErrorHandler.handle(e);
    }
  }
}