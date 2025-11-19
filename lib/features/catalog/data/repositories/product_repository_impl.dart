import 'package:catalog/core/services/logger.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_datasource.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;

  @override
  Future<List<Product>> getProducts() async {
    try {
      final localProducts = await _localDataSource.getProducts();
      if (localProducts.isNotEmpty) {
        return localProducts.map((model) => _toEntity(model)).toList();
      }

      final remoteModels = await _remoteDataSource.getProducts();
      await _localDataSource.saveProducts(remoteModels);
      return remoteModels.map((model) => _toEntity(model)).toList();
    } catch (e) {
      Logger.error('Failed to get products from remote, trying local storage', error: e);
      final localProducts = await _localDataSource.getProducts();
      return localProducts.map((model) => _toEntity(model)).toList();
    }
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    try {
      final localProducts =
          await _localDataSource.getProductsByCategory(category);
      if (localProducts.isNotEmpty) {
        return localProducts.map((model) => _toEntity(model)).toList();
      }

      final remoteModels =
          await _remoteDataSource.getProductsByCategory(category);
      await _localDataSource.saveProducts(remoteModels);
      return remoteModels.map((model) => _toEntity(model)).toList();
    } catch (e) {
      Logger.error('Failed to get products by category from remote, trying local storage', error: e);
      final localProducts =
          await _localDataSource.getProductsByCategory(category);
      return localProducts.map((model) => _toEntity(model)).toList();
    }
  }

  @override
  Future<List<String>> getCategories() async {
    return _remoteDataSource.getCategories();
  }

  Product _toEntity(ProductModel model) {
    return Product(
      id: model.id,
      title: model.title,
      price: model.price,
      description: model.description,
      category: model.category,
      image: model.image,
      rating: model.rating,
    );
  }
}

