import 'package:equatable/equatable.dart';

class SubUnit {
  final int id;
  final String subUnit;
  final String? subUnitEn;
  final double subPrice;
  final int subQuantity;

  const SubUnit({
    required this.id,
    required this.subUnit,
    this.subUnitEn,
    required this.subPrice,
    required this.subQuantity,
  });
}

class ProductEntity extends Equatable {
  final int id;
  final String name;
  final String? nameEn;
  final String? image;
  final String? imageUrl;
  final double price;
  final double? priceAfterDiscount;
  final String? description;
  final String? descriptionEn;
  final int? vendorId;
  final int? categoryId;
  final String? categoryName;
  final int? quantity;
  final String? unit;
  final List<SubUnit> subUnits;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    this.nameEn,
    this.image,
    this.imageUrl,
    this.priceAfterDiscount,
    this.description,
    this.descriptionEn,
    this.vendorId,
    this.categoryId,
    this.categoryName,
    this.quantity,
    this.unit,
    this.subUnits = const [],
  });

  @override
  List<Object?> get props => [id];
}