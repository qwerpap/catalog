import 'package:catalog/core/services/logger.dart';
import 'package:drift/drift.dart';
import '../../domain/entities/product.dart' as domain;
import '../database/catalog_database.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<void> saveProducts(List<ProductModel> products);
  Future<void> clearProducts();
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  ProductLocalDataSourceImpl(this._database);

  final CatalogDatabase _database;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final products = await _database.select(_database.products).get();
      return products.map((product) => _toModel(product)).toList();
    } catch (e) {
      Logger.error('Failed to get products from local storage', error: e);
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final products = await (_database.select(_database.products)
            ..where((p) => p.category.equals(category)))
          .get();
      return products.map((product) => _toModel(product)).toList();
    } catch (e) {
      Logger.error(
        'Failed to get products by category from local storage',
        error: e,
      );
      rethrow;
    }
  }

  @override
  Future<void> saveProducts(List<ProductModel> products) async {
    try {
      await _database.batch((batch) {
        batch.deleteAll(_database.products);
        batch.insertAll(
          _database.products,
          products.map((product) => ProductsCompanion.insert(
                id: Value(product.id),
                title: product.title,
                price: product.price,
                description: product.description,
                category: product.category,
                image: product.image,
                ratingRate: Value(product.rating?.rate),
                ratingCount: Value(product.rating?.count),
              )),
        );
      });
    } catch (e) {
      Logger.error('Failed to save products to local storage', error: e);
      rethrow;
    }
  }

  @override
  Future<void> clearProducts() async {
    try {
      await _database.delete(_database.products).go();
    } catch (e) {
      Logger.error('Failed to clear products from local storage', error: e);
      rethrow;
    }
  }

  ProductModel _toModel(Product product) {
    return ProductModel(
      id: product.id,
      title: product.title,
      price: product.price,
      description: product.description,
      category: product.category,
      image: product.image,
      rating: product.ratingRate != null && product.ratingCount != null
          ? domain.ProductRating(
              rate: product.ratingRate!,
              count: product.ratingCount!,
            )
          : null,
    );
  }
}

