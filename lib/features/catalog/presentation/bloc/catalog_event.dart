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

