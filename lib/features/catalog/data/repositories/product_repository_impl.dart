import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<Product>> getProducts() async {
    return _remoteDataSource.getProducts();
  }

  @override
  Future<List<Product>> getProductsByCategory(String category) async {
    return _remoteDataSource.getProductsByCategory(category);
  }

  @override
  Future<List<String>> getCategories() async {
    return _remoteDataSource.getCategories();
  }
}

