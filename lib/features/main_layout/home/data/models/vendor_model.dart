import '../../domain/entities/vendor_entity.dart';

import '../../domain/entities/vendor_entity.dart';

class VendorModel extends VendorEntity {
  const VendorModel({
    required super.id,
    required super.name,
    super.logo,
    super.logoUrl,
    super.rating,
    super.isFreeDelivery,
    super.status,
    super.category,
    super.distance,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
    id: json['id'] ?? 0,
    name: json['name'] ?? '',
    logo: json['img'],
    logoUrl: json['img'] != null
        ? 'https://fruits.sys-web.net/storage/${json['img']}'
        : null,
    rating: json['rate'] != null
        ? double.tryParse(json['rate'].toString())
        : null,
    isFreeDelivery: json['delivery_charges'] == null,
    status: json['is_opened'] == 'Y' ? 'Open' : 'Close',
    category: json['category'],
    distance: null,
  );
}