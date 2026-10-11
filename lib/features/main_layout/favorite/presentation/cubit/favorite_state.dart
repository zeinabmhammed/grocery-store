import 'package:equatable/equatable.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/product_entity.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}
class FavoriteLoading extends FavoriteState {}

class FavoriteUpdated extends FavoriteState {
  final List<ProductEntity> favorites;
  final Set<int> favoriteIds; // ← عشان نعرف بسرعة لو المنتج في المفضلة

  const FavoriteUpdated({
    required this.favorites,
    required this.favoriteIds,
  });

  bool isFavorite(int productId) => favoriteIds.contains(productId);

  @override
  List<Object?> get props => [favorites, favoriteIds];
}

class FavoriteError extends FavoriteState {
  final String message;
  const FavoriteError(this.message);
  @override
  List<Object?> get props => [message];
}
