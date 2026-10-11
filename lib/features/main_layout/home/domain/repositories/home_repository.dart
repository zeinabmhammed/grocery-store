import 'package:dartz/dartz.dart';
import 'package:greengrocer/core/errors/failures.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/category_entity.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/slider_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<SliderEntity>>> getSliders();
  Future<Either<Failure, List<CategoryEntity>>> getCategories();
}
