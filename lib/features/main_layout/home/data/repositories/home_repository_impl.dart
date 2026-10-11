import 'package:dartz/dartz.dart';
import 'package:greengrocer/core/errors/failures.dart';
import '../../domain/repositories/home_repository.dart';
import '../../domain/entities/slider_entity.dart';
import '../../domain/entities/category_entity.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SliderEntity>>> getSliders() async {
    try {
      final models = await remoteDataSource.getSliders();
      final entities = models
          .map((m) => SliderEntity(id: m.id, img: m.img, link: m.link))
          .toList();
      return Right(entities);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final models = await remoteDataSource.getCategories();
      final entities = models
          .map((m) => CategoryEntity(
        id: m.id,
        name: m.name,
        nameEn: m.nameEn,
        img: m.img,
        parentId: m.parentId,
      ))
          .toList();
      return Right(entities);
    } on Failure catch (f) {
      return Left(f);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}

 