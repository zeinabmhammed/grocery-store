import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greengrocer/features/auth/domain/usecases/auth_usecases.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/product_entity.dart';
import 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  final AddToFavoriteUseCase addToFavoriteUseCase;

  final List<ProductEntity> _favorites = [];
  final Set<int> _favoriteIds = {};

  FavoriteCubit({required this.addToFavoriteUseCase})
      : super(FavoriteInitial());

  // ── Toggle Favorite ───────────────────────────────────────
  Future<void> toggleFavorite(ProductEntity product) async {
    final isCurrentlyFavorite = _favoriteIds.contains(product.id);

    // ← Update UI فوراً (Optimistic Update)
    if (isCurrentlyFavorite) {
      _favorites.removeWhere((p) => p.id == product.id);
      _favoriteIds.remove(product.id);
    } else {
      _favorites.add(product);
      _favoriteIds.add(product.id);
    }
    _emitUpdated();

    // ← بعدين ابعت للـ API
    final result = await addToFavoriteUseCase(product.id);
    result.fold(
          (failure) {
        // لو فشل ارجع للحالة الأصلية
        if (isCurrentlyFavorite) {
          _favorites.add(product);
          _favoriteIds.add(product.id);
        } else {
          _favorites.removeWhere((p) => p.id == product.id);
          _favoriteIds.remove(product.id);
        }
        _emitUpdated();
      },
          (_) {}, // نجح → مش محتاج نعمل حاجة
    );
  }

  bool isFavorite(int productId) => _favoriteIds.contains(productId);

  void _emitUpdated() => emit(FavoriteUpdated(
    favorites: List.from(_favorites),
    favoriteIds: Set.from(_favoriteIds),
  ));
}