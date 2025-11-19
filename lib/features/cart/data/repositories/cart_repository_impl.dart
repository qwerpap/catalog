import 'package:catalog/core/services/logger.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl() : _items = <CartItem>[];

  final List<CartItem> _items;

  @override
  Future<List<CartItem>> getCartItems() async {
    try {
      return List<CartItem>.from(_items);
    } catch (e) {
      Logger.error('Failed to get cart items', error: e);
      rethrow;
    }
  }

  @override
  Future<void> addToCart(CartItem item) async {
    try {
      final existingIndex = _items.indexWhere(
        (element) => element.product.id == item.product.id,
      );

      if (existingIndex != -1) {
        final existingItem = _items[existingIndex];
        _items[existingIndex] = existingItem.copyWith(
          quantity: existingItem.quantity + item.quantity,
        );
      } else {
        _items.add(item);
      }
    } catch (e) {
      Logger.error('Failed to add to cart', error: e);
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    try {
      _items.removeWhere((item) => item.product.id == productId);
    } catch (e) {
      Logger.error('Failed to remove from cart', error: e);
      rethrow;
    }
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      final index = _items.indexWhere(
        (element) => element.product.id == productId,
      );

      if (index != -1) {
        if (quantity <= 0) {
          _items.removeAt(index);
        } else {
          final existingItem = _items[index];
          _items[index] = existingItem.copyWith(quantity: quantity);
        }
      }
    } catch (e) {
      Logger.error('Failed to update quantity', error: e);
      rethrow;
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      _items.clear();
    } catch (e) {
      Logger.error('Failed to clear cart', error: e);
      rethrow;
    }
  }
}

