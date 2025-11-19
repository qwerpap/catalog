import 'package:equatable/equatable.dart';
import '../../domain/entities/product.dart';

abstract class CatalogState extends Equatable {
  const CatalogState();

  @override
  List<Object?> get props => [];
}

class CatalogInitial extends CatalogState {
  const CatalogInitial();
}

class CatalogLoading extends CatalogState {
  const CatalogLoading();
}

class CatalogLoaded extends CatalogState {
  const CatalogLoaded({
    required this.products,
    this.categories = const [],
    this.selectedCategory,
  });

  final List<Product> products;
  final List<String> categories;
  final String? selectedCategory;

  @override
  List<Object?> get props => [products, categories, selectedCategory];
}

class CatalogError extends CatalogState {
  const CatalogError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

