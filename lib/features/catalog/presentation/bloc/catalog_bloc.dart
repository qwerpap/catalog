import 'package:catalog/core/services/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/get_products_by_category_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
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
  }

  final GetProductsUseCase _getProductsUseCase;
  final GetProductsByCategoryUseCase _getProductsByCategoryUseCase;
  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> _onLoadProducts(
    CatalogLoadProducts event,
    Emitter<CatalogState> emit,
  ) async {
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

  Future<void> _onLoadProductsByCategory(
    CatalogLoadProductsByCategory event,
    Emitter<CatalogState> emit,
  ) async {
    emit(const CatalogLoading());
    try {
      final products = await _getProductsByCategoryUseCase(event.category);
      final categories = await _getCategoriesUseCase();
      emit(
        CatalogLoaded(
          products: products,
          categories: categories,
          selectedCategory: event.category,
        ),
      );
    } catch (e) {
      Logger.error('Failed to load products by category', error: e);
      emit(CatalogError('Failed to load products: ${e.toString()}'));
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
          CatalogLoaded(
            products: currentState.products,
            categories: categories,
            selectedCategory: currentState.selectedCategory,
          ),
        );
      }
    } catch (e) {
      Logger.error('Failed to load categories', error: e);
    }
  }
}

