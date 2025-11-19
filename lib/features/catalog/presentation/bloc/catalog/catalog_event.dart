import 'package:equatable/equatable.dart';

abstract class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object?> get props => [];
}

class CatalogLoadProducts extends CatalogEvent {
  const CatalogLoadProducts();
}

class CatalogLoadProductsByCategory extends CatalogEvent {
  const CatalogLoadProductsByCategory(this.category);

  final String category;

  @override
  List<Object?> get props => [category];
}

class CatalogLoadCategories extends CatalogEvent {
  const CatalogLoadCategories();
}

class CatalogSearchProducts extends CatalogEvent {
  const CatalogSearchProducts(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

class CatalogSortProducts extends CatalogEvent {
  const CatalogSortProducts(this.sortType);

  final ProductSortType sortType;

  @override
  List<Object?> get props => [sortType];
}

class CatalogFilterByPrice extends CatalogEvent {
  const CatalogFilterByPrice({
    this.minPrice,
    this.maxPrice,
  });

  final double? minPrice;
  final double? maxPrice;

  @override
  List<Object?> get props => [minPrice, maxPrice];
}

enum ProductSortType {
  none,
  priceAsc,
  priceDesc,
}

