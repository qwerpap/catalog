import 'package:catalog/core/services/logger.dart';
import 'package:dio/dio.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  ProductRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get('/products');
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to load products');
    } on DioException catch (e) {
      Logger.error('Failed to get products', error: e);
      throw Exception('Failed to load products: ${e.message}');
    } catch (e) {
      Logger.error('Unexpected error getting products', error: e);
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final encodedCategory = Uri.encodeComponent(category);
      final response = await _dio.get('/products/category/$encodedCategory');
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
            .toList();
      }
      throw Exception('Failed to load products by category');
    } on DioException catch (e) {
      Logger.error('Failed to get products by category', error: e);
      throw Exception('Failed to load products: ${e.message}');
    } catch (e) {
      Logger.error('Unexpected error getting products by category', error: e);
      throw Exception('Unexpected error: $e');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get('/products/categories');
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data.map((item) => item.toString()).toList();
      }
      throw Exception('Failed to load categories');
    } on DioException catch (e) {
      Logger.error('Failed to get categories', error: e);
      throw Exception('Failed to load categories: ${e.message}');
    } catch (e) {
      Logger.error('Unexpected error getting categories', error: e);
      throw Exception('Unexpected error: $e');
    }
  }
}

