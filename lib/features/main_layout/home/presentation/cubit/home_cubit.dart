import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/core/usecases/usecase.dart';
import '../../domain/usecases/get_sliders_usecase.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetSlidersUseCase getSlidersUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;

  HomeCubit({
    required this.getSlidersUseCase,
    required this.getCategoriesUseCase,
  }) : super(HomeInitial());

  Future<void> loadHomeData() async {
    emit(HomeLoading());
    final slidersResult = await getSlidersUseCase(NoParams());
    final categoriesResult = await getCategoriesUseCase(NoParams());

    slidersResult.fold(
          (failure) => emit(HomeError(failure.message)),
          (sliders) => categoriesResult.fold(
            (failure) => emit(HomeError(failure.message)),
            (categories) => emit(HomeSuccess(sliders: sliders, categories: categories)),
      ),
    );
  }
}