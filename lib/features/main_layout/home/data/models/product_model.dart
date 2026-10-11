import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.name,
    required super.price,
    super.nameEn,
    super.image,
    super.imageUrl,
    super.priceAfterDiscount,
    super.description,
    super.descriptionEn,
    super.vendorId,
    super.categoryId,
    super.categoryName,
    super.quantity,
    super.unit,
    super.subUnits,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final List subUnitsJson = json['sub_units'] ?? [];
    final subUnits = subUnitsJson
        .map((e) => SubUnit(
      id: e['id'] ?? 0,
      subUnit: e['sub_unit'] ?? '',
      subUnitEn: e['sub_unit_en'],
      subPrice: double.tryParse(e['sub_price'].toString()) ?? 0.0,
      subQuantity: e['sub_quantity'] ?? 0,
    ))
        .toList();

    return ProductModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      nameEn: json['name_en'],
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      image: json['img'],
      imageUrl: json['img'] != null
          ? 'https://fruits.sys-web.net/storage/${json['img']}'
          : null,
      priceAfterDiscount: json['price_after_discount'] != null
          ? double.tryParse(json['price_after_discount'].toString())
          : null,
      description: json['details'],
      descriptionEn: json['details_en'],
      vendorId: json['vendor_id'],
      categoryId: json['category_id'],
      categoryName: json['name_category'],
      quantity: json['quantity'],
      unit: json['unit'],
      subUnits: subUnits,
    );
  }
}