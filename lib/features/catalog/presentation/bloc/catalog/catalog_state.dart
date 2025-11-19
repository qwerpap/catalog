import 'package:equatable/equatable.dart';
import '../../../domain/entities/product.dart';
import 'catalog_event.dart';

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
    this.searchQuery = '',
    this.sortType = ProductSortType.none,
    this.minPrice,
    this.maxPrice,
  });

  final List<Product> products;
  final List<String> categories;
  final String? selectedCategory;
  final String searchQuery;
  final ProductSortType sortType;
  final double? minPrice;
  final double? maxPrice;

  List<Product> get filteredAndSortedProducts {
    var result = List<Product>.from(products);

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      result = result
          .where((product) =>
              product.title.toLowerCase().contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Apply price filter
    if (minPrice != null) {
      result = result.where((product) => product.price >= minPrice!).toList();
    }
    if (maxPrice != null) {
      result = result.where((product) => product.price <= maxPrice!).toList();
    }

    // Apply sorting
    switch (sortType) {
      case ProductSortType.priceAsc:
        result.sort((a, b) => a.price.compareTo(b.price));
        break;
      case ProductSortType.priceDesc:
        result.sort((a, b) => b.price.compareTo(a.price));
        break;
      case ProductSortType.none:
        break;
    }

    return result;
  }

  CatalogLoaded copyWith({
    List<Product>? products,
    List<String>? categories,
    String? selectedCategory,
    String? searchQuery,
    ProductSortType? sortType,
    double? minPrice,
    double? maxPrice,
  }) {
    return CatalogLoaded(
      products: products ?? this.products,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      searchQuery: searchQuery ?? this.searchQuery,
      sortType: sortType ?? this.sortType,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [
        products,
        categories,
        selectedCategory,
        searchQuery,
        sortType,
        minPrice,
        maxPrice,
      ];
}

class CatalogError extends CatalogState {
  const CatalogError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

