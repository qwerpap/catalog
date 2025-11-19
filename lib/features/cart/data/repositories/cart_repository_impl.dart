import 'package:catalog/core/services/logger.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_datasource.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl(this._localDataSource);

  final CartLocalDataSource _localDataSource;

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      return await _localDataSource.getCartItems();
    } catch (e) {
      Logger.error('Failed to get cart items', error: e);
      rethrow;
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    try {
      await _localDataSource.addToCart(item);
    } catch (e) {
      Logger.error('Failed to add to cart', error: e);
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    try {
      await _localDataSource.removeFromCart(productId);
    } catch (e) {
      Logger.error('Failed to remove from cart', error: e);
      rethrow;
    }
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      await _localDataSource.updateQuantity(productId, quantity);
    } catch (e) {
      Logger.error('Failed to update quantity', error: e);
      rethrow;
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await _localDataSource.clearCart();
    } catch (e) {
      Logger.error('Failed to clear cart', error: e);
      rethrow;
    }
  }
}

