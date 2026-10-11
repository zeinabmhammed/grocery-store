import 'package:dartz/dartz.dart';
import 'package:greengrocer/core/errors/failures.dart';
import 'package:greengrocer/core/usecases/usecase.dart';
import '../entities/slider_entity.dart';
import '../repositories/home_repository.dart';

class GetSlidersUseCase implements UseCase<List<SliderEntity>, NoParams> {
  final HomeRepository repository;
  GetSlidersUseCase(this.repository);

  @override
  Future<Either<Failure, List<SliderEntity>>> call(NoParams params) =>
      repository.getSliders();
}