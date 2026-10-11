import 'package:greengrocer/features/main_layout/home/domain/entities/category_entity.dart';
import 'package:greengrocer/features/main_layout/home/domain/entities/product_entity.dart';


class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.nameEn,
    required super.img,
    super.parentId,
    super.products,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json, {List<ProductEntity> products = const []}) {
    return CategoryModel(
      id: json['id'],
      name: json['name'] ?? '',
      nameEn: json['name_en'] ?? '',
      img: json['img'] ?? '',
      parentId: json['parent_id'],
      products: products,
    );
  }
}