import 'package:equatable/equatable.dart';
import '../catalog/catalog_event.dart';

abstract class FiltersEvent extends Equatable {
  const FiltersEvent();

  @override
  List<Object?> get props => [];
}

class FiltersLoadInitial extends FiltersEvent {
  const FiltersLoadInitial();
}

class FiltersCategoryChanged extends FiltersEvent {
  const FiltersCategoryChanged(this.category);

  final String? category;

  @override
  List<Object?> get props => [category];
}

class FiltersMinPriceChanged extends FiltersEvent {
  const FiltersMinPriceChanged(this.minPrice);

  final String minPrice;

  @override
  List<Object?> get props => [minPrice];
}

class FiltersMaxPriceChanged extends FiltersEvent {
  const FiltersMaxPriceChanged(this.maxPrice);

  final String maxPrice;

  @override
  List<Object?> get props => [maxPrice];
}

class FiltersSortTypeChanged extends FiltersEvent {
  const FiltersSortTypeChanged(this.sortType);

  final ProductSortType sortType;

  @override
  List<Object?> get props => [sortType];
}

class FiltersApply extends FiltersEvent {
  const FiltersApply();
}

class FiltersClear extends FiltersEvent {
  const FiltersClear();
}

