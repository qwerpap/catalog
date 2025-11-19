import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getProducts() async {
    final models = await _remoteDataSource.getProducts();
    return models.map((model) => _toEntity(model)).toList();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    final models = await _remoteDataSource.getProductsByCategory(category);
    return models.map((model) => _toEntity(model)).toList();
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

