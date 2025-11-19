import 'package:catalog/core/services/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../catalog/catalog_bloc.dart';
import '../catalog/catalog_event.dart';
import '../catalog/catalog_state.dart';
import 'filters_event.dart';
import 'filters_state.dart';

class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  FiltersBloc(this._catalogBloc) : super(const FiltersState()) {
    on<FiltersLoadInitial>(_onLoadInitial);
    on<FiltersCategoryChanged>(_onCategoryChanged);
    on<FiltersMinPriceChanged>(_onMinPriceChanged);
    on<FiltersMaxPriceChanged>(_onMaxPriceChanged);
    on<FiltersSortTypeChanged>(_onSortTypeChanged);
    on<FiltersApply>(_onApply);
    on<FiltersClear>(_onClear);
  }

  final CatalogBloc _catalogBloc;

  void _onLoadInitial(
    FiltersLoadInitial event,
    Emitter<FiltersState> emit,
  ) {
    final catalogState = _catalogBloc.state;
    if (catalogState is CatalogLoaded) {
      emit(
        FiltersState(
          selectedCategory: catalogState.selectedCategory,
          minPrice: catalogState.minPrice,
          maxPrice: catalogState.maxPrice,
          minPriceText: catalogState.minPrice?.toString() ?? '',
          maxPriceText: catalogState.maxPrice?.toString() ?? '',
          sortType: catalogState.sortType,
        ),
      );
    }
  }

  void _onCategoryChanged(
    FiltersCategoryChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(
      state.copyWith(
        selectedCategory: event.category,
        clearSelectedCategory: event.category == null,
      ),
    );
  }

  void _onMinPriceChanged(
    FiltersMinPriceChanged event,
    Emitter<FiltersState> emit,
  ) {
    final minPrice = event.minPrice.isNotEmpty
        ? double.tryParse(event.minPrice)
        : null;
    emit(
      state.copyWith(
        minPrice: minPrice,
        minPriceText: event.minPrice,
      ),
    );
  }

  void _onMaxPriceChanged(
    FiltersMaxPriceChanged event,
    Emitter<FiltersState> emit,
  ) {
    final maxPrice = event.maxPrice.isNotEmpty
        ? double.tryParse(event.maxPrice)
        : null;
    emit(
      state.copyWith(
        maxPrice: maxPrice,
        maxPriceText: event.maxPrice,
      ),
    );
  }

  void _onSortTypeChanged(
    FiltersSortTypeChanged event,
    Emitter<FiltersState> emit,
  ) {
    emit(state.copyWith(sortType: event.sortType));
  }

  void _onApply(
    FiltersApply event,
    Emitter<FiltersState> emit,
  ) {
    try {
      final catalogState = _catalogBloc.state;
      final currentCategory = catalogState is CatalogLoaded
          ? catalogState.selectedCategory
          : null;

      // Check if category changed
      final categoryChanged = currentCategory != state.selectedCategory;

      // Apply price filter
      _catalogBloc.add(
        CatalogFilterByPrice(
          minPrice: state.minPrice,
          maxPrice: state.maxPrice,
        ),
      );

      // Apply sort
      _catalogBloc.add(CatalogSortProducts(state.sortType));

      // Apply category filter only if category changed
      if (categoryChanged) {
        if (state.selectedCategory == null) {
          _catalogBloc.add(const CatalogLoadProducts());
        } else {
          _catalogBloc.add(
            CatalogLoadProductsByCategory(state.selectedCategory!),
          );
        }
      }

      Logger.info('Filters applied');
    } catch (e) {
      Logger.error('Failed to apply filters', error: e);
    }
  }

  void _onClear(
    FiltersClear event,
    Emitter<FiltersState> emit,
  ) {
    emit(const FiltersState());

    _catalogBloc.add(const CatalogLoadProducts());
    _catalogBloc.add(
      const CatalogFilterByPrice(minPrice: null, maxPrice: null),
    );
    _catalogBloc.add(
      const CatalogSortProducts(ProductSortType.none),
    );

    Logger.info('Filters cleared');
  }
}

