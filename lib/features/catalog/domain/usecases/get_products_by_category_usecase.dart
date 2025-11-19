import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProductsByCategoryUseCase {
  const GetProductsByCategoryUseCase(this._repository);

  final ProductRepository _repository;

  Future<List<Product>> call(String category) async {
    return _repository.getProductsByCategory(category);
  }
}

