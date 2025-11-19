import 'package:catalog/core/network/dio_client.dart';
import 'package:catalog/core/theme/data/theme_storage.dart';
import 'package:catalog/core/theme/presentation/bloc/theme_bloc.dart';
import 'package:catalog/features/catalog/data/datasources/product_remote_datasource.dart';
import 'package:catalog/features/catalog/data/repositories/product_repository_impl.dart';
import 'package:catalog/features/catalog/domain/repositories/product_repository.dart';
import 'package:catalog/features/catalog/domain/usecases/get_categories_usecase.dart';
import 'package:catalog/features/catalog/domain/usecases/get_products_by_category_usecase.dart';
import 'package:catalog/features/catalog/domain/usecases/get_products_usecase.dart';
import 'package:catalog/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjection {
  DependencyInjection._();

  static Dio? _dio;
  static ProductRemoteDataSource? _productRemoteDataSource;
  static ProductRepository? _productRepository;
  static GetProductsUseCase? _getProductsUseCase;
  static GetProductsByCategoryUseCase? _getProductsByCategoryUseCase;
  static GetCategoriesUseCase? _getCategoriesUseCase;
  static CatalogBloc? _catalogBloc;
  static SharedPreferences? _sharedPreferences;
  static ThemeStorage? _themeStorage;
  static ThemeBloc? _themeBloc;

  static Dio get dio {
    _dio ??= DioClient.instance;
    return _dio!;
  }

  static ProductRemoteDataSource get productRemoteDataSource {
    _productRemoteDataSource ??= ProductRemoteDataSourceImpl(dio);
    return _productRemoteDataSource!;
  }

  static ProductRepository get productRepository {
    _productRepository ??= ProductRepositoryImpl(productRemoteDataSource);
    return _productRepository!;
  }

  static GetProductsUseCase get getProductsUseCase {
    _getProductsUseCase ??= GetProductsUseCase(productRepository);
    return _getProductsUseCase!;
  }

  static GetProductsByCategoryUseCase get getProductsByCategoryUseCase {
    _getProductsByCategoryUseCase ??=
        GetProductsByCategoryUseCase(productRepository);
    return _getProductsByCategoryUseCase!;
  }

  static GetCategoriesUseCase get getCategoriesUseCase {
    _getCategoriesUseCase ??= GetCategoriesUseCase(productRepository);
    return _getCategoriesUseCase!;
  }

  static CatalogBloc get catalogBloc {
    _catalogBloc ??= CatalogBloc(
      getProductsUseCase: getProductsUseCase,
      getProductsByCategoryUseCase: getProductsByCategoryUseCase,
      getCategoriesUseCase: getCategoriesUseCase,
    );
    return _catalogBloc!;
  }

  static Future<SharedPreferences> get sharedPreferences async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  static Future<ThemeStorage> get themeStorage async {
    final prefs = await sharedPreferences;
    _themeStorage ??= ThemeStorage(prefs);
    return _themeStorage!;
  }

  static Future<ThemeBloc> get themeBloc async {
    final storage = await themeStorage;
    _themeBloc ??= ThemeBloc(storage);
    return _themeBloc!;
  }
}

