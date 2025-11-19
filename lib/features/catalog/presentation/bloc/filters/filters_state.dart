import 'package:equatable/equatable.dart';
import '../catalog/catalog_event.dart';

class FiltersState extends Equatable {
  const FiltersState({
    this.selectedCategory,
    this.minPrice,
    this.maxPrice,
    this.minPriceText = '',
    this.maxPriceText = '',
    this.sortType = ProductSortType.none,
  });

  final String? selectedCategory;
  final double? minPrice;
  final double? maxPrice;
  final String minPriceText;
  final String maxPriceText;
  final ProductSortType sortType;

  FiltersState copyWith({
    String? selectedCategory,
    double? minPrice,
    double? maxPrice,
    String? minPriceText,
    String? maxPriceText,
    ProductSortType? sortType,
    bool clearSelectedCategory = false,
    bool clearMinPrice = false,
    bool clearMaxPrice = false,
  }) {
    return FiltersState(
      selectedCategory: clearSelectedCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
      minPrice: clearMinPrice ? null : (minPrice ?? this.minPrice),
      maxPrice: clearMaxPrice ? null : (maxPrice ?? this.maxPrice),
      minPriceText: minPriceText ?? this.minPriceText,
      maxPriceText: maxPriceText ?? this.maxPriceText,
      sortType: sortType ?? this.sortType,
    );
  }

  @override
  List<Object?> get props => [
        selectedCategory,
        minPrice,
        maxPrice,
        minPriceText,
        maxPriceText,
        sortType,
      ];
}

