import 'package:equatable/equatable.dart';

class VendorEntity extends Equatable {
  final int id;
  final String name;
  final String? logo;
  final String? logoUrl;
  final double? rating;
  final bool isFreeDelivery;
  final String? status;
  final String? category;
  final String? distance;

  const VendorEntity({
required this.id,
required this.name,
this.logo,
this.logoUrl,
this.rating,
this.isFreeDelivery = false,
this.status,
this.category,
this.distance,
});

@override
List<Object?> get props => [id];
}