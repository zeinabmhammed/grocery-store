import 'product_entity.dart';

class CategoryEntity {
  final int id;
  final String name;
  final String nameEn;
  final String img;
  final int? parentId;
  final List<ProductEntity> products;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.img,
    this.parentId,
    this.products = const [],
  });
}