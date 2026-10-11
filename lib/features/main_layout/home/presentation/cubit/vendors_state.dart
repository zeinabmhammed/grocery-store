import 'package:equatable/equatable.dart';
import '../../domain/entities/vendor_entity.dart';

abstract class VendorsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VendorsInitial extends VendorsState {}

class VendorsLoading extends VendorsState {}

class VendorsSuccess extends VendorsState {
  final List<VendorEntity> vendors;
  VendorsSuccess(this.vendors);

  @override
  List<Object?> get props => [vendors];
}

class VendorsError extends VendorsState {
  final String message;
  VendorsError(this.message);

  @override
  List<Object?> get props => [message];
}