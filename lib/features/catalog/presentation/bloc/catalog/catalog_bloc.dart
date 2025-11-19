import 'package:catalog/core/services/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_categories_usecase.dart';
import '../../../domain/usecases/get_products_by_category_usecase.dart';
import '../../../domain/usecases/get_products_usecase.dart';
import 'catalog_event.dart';
import 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({
    required GetProductsUseCase getProductsUseCase,
    required GetProductsByCategoryUseCase getProductsByCategoryUseCase,
    required GetCategoriesUseCase getCategoriesUseCase,
  })  : _getProductsUseCase = getProductsUseCase,
        _getProductsByCategoryUseCase = getProductsByCategoryUseCase,
        _getCategoriesUseCase = getCategoriesUseCase,
        super(const CatalogInitial()) {
    on<CatalogLoadProducts>(_onLoadProducts);
    on<CatalogLoadProductsByCategory>(_onLoadProductsByCategory);
    on<CatalogLoadCategories>(_onLoadCategories);
    on<CatalogSearchProducts>(_onSearchProducts);
    on<CatalogSortProducts>(_onSortProducts);
    on<CatalogFilterByPrice>(_onFilterByPrice);
  }

  final GetProductsUseCase _getProductsUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;
  CancelToken? _categoryCancelToken;

  Future<void> _onLoadProducts(
    CatalogLoadProducts event,
    Emitter<CatalogState> emit,
  ) async {
    // If we already have data, preserve categories and just update products
    if (state is CatalogLoaded) {
      final currentState = state as CatalogLoaded;
      final currentCategories = currentState.categories;
      final currentSearchQuery = currentState.searchQuery;
      final currentSortType = currentState.sortType;
      final currentMinPrice = currentState.minPrice;
      final currentMaxPrice = currentState.maxPrice;

      try {
        final products = await _getProductsUseCase();
        emit(
          CatalogLoaded(
            products: products,
            categories: currentCategories.isNotEmpty
                ? currentCategories
                : await _getCategoriesUseCase(),
            selectedCategory: null,
            searchQuery: currentSearchQuery,
            sortType: currentSortType,
            minPrice: currentMinPrice,
            maxPrice: currentMaxPrice,
          ),
        );
      } catch (e) {
        Logger.error('Failed to load products', error: e);
        // Keep current state on error
        emit(currentState);
      }
    } else {
      emit(const CatalogLoading());
      try {
        final products = await _getProductsUseCase();
        final categories = await _getCategoriesUseCase();
        emit(
          CatalogLoaded(
            products: products,
            categories: categories,
          ),
        );
      } catch (e) {
        Logger.error('Failed to load products', error: e);
        emit(CatalogError('Failed to load products: ${e.toString()}'));
      }
    }
  }

  Future<void> _onLoadProductsByCategory(
    CatalogLoadProductsByCategory event,
    Emitter<CatalogState> emit,
  ) async {
    // Cancel previous request if exists
    _categoryCancelToken?.cancel();
    _categoryCancelToken = CancelToken();

    // If we already have data, preserve it and just update products
    if (state is CatalogLoaded) {
      final currentState = state as CatalogLoaded;
      final currentCategories = currentState.categories;
      final currentSearchQuery = currentState.searchQuery;
      final currentSortType = currentState.sortType;
      final currentMinPrice = currentState.minPrice;
      final currentMaxPrice = currentState.maxPrice;

      try {
        final products = await _getProductsByCategoryUseCase(event.category);
        // Check if request was cancelled
        if (_categoryCancelToken?.isCancelled == true) {
          return;
        }
        emit(
          CatalogLoaded(
            products: products,
            categories: currentCategories,
            selectedCategory: event.category,
            searchQuery: currentSearchQuery,
            sortType: currentSortType,
            minPrice: currentMinPrice,
            maxPrice: currentMaxPrice,
          ),
        );
      } on DioException catch (e) {
        if (e.type == DioExceptionType.cancel) {
          Logger.debug('Request cancelled for category: ${event.category}');
          return;
        }
        Logger.error('Failed to load products by category', error: e);
        // Keep current state on error
        emit(
          CatalogLoaded(
            products: currentState.products,
            categories: currentCategories,
            selectedCategory: currentState.selectedCategory,
            searchQuery: currentSearchQuery,
            sortType: currentSortType,
            minPrice: currentMinPrice,
            maxPrice: currentMaxPrice,
          ),
        );
      } catch (e) {
        Logger.error('Failed to load products by category', error: e);
        emit(
          CatalogLoaded(
            products: currentState.products,
            categories: currentCategories,
            selectedCategory: currentState.selectedCategory,
            searchQuery: currentSearchQuery,
            sortType: currentSortType,
            minPrice: currentMinPrice,
            maxPrice: currentMaxPrice,
          ),
        );
      }
    } else {
      // If no data yet, show loading
      emit(const CatalogLoading());
      try {
        final products = await _getProductsByCategoryUseCase(event.category);
        if (_categoryCancelToken?.isCancelled == true) {
          return;
        }
        final categories = await _getCategoriesUseCase();
        emit(
          CatalogLoaded(
            products: products,
            categories: categories,
            selectedCategory: event.category,
          ),
        );
      } catch (e) {
        if (e is DioException && e.type == DioExceptionType.cancel) {
          return;
        }
        Logger.error('Failed to load products by category', error: e);
        emit(CatalogError('Failed to load products: ${e.toString()}'));
      }
    }
  }

  Future<void> _onLoadCategories(
    CatalogLoadCategories event,
    Emitter<CatalogState> emit,
  ) async {
    try {
      final categories = await _getCategoriesUseCase();
      if (state is CatalogLoaded) {
        final currentState = state as CatalogLoaded;
        emit(
          currentState.copyWith(categories: categories),
        );
      }
    } catch (e) {
      Logger.error('Failed to load categories', error: e);
    }
  }

  Future<void> _onSearchProducts(
    CatalogSearchProducts event,
    Emitter<CatalogState> emit,
  ) async {
    if (state is CatalogLoaded) {
      final currentState = state as CatalogLoaded;
      emit(currentState.copyWith(searchQuery: event.query));
    }
  }

  Future<void> _onSortProducts(
    CatalogSortProducts event,
    Emitter<CatalogState> emit,
  ) async {
    if (state is CatalogLoaded) {
      final currentState = state as CatalogLoaded;
      emit(currentState.copyWith(sortType: event.sortType));
    }
  }

  Future<void> _onFilterByPrice(
    CatalogFilterByPrice event,
    Emitter<CatalogState> emit,
  ) async {
    if (state is CatalogLoaded) {
      final currentState = state as CatalogLoaded;
      emit(
        currentState.copyWith(
          minPrice: event.minPrice,
          maxPrice: event.maxPrice,
        ),
      );
    }
  }
}

