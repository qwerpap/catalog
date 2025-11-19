import 'package:catalog/core/services/logger.dart';
import 'package:drift/drift.dart';
import '../../../catalog/domain/entities/product.dart' as domain;
import '../database/cart_database.dart';
import '../../domain/entities/cart_item.dart' as domain_entity;

abstract class CartLocalDataSource {
  Future<List<domain_entity.CartItem>> getCartItems();
  Future<void> addToCart(domain_entity.CartItem item);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartLocalDataSourceImpl(this._database);

  final CartDatabase _database;

  @override
  Future<List<domain_entity.CartItem>> getCartItems() async {
    try {
      final cartItems = await _database.select(_database.cartItems).get();
      final cartItemsList = <domain_entity.CartItem>[];

      for (final cartItem in cartItems) {
        final product = await _getProductById(cartItem.productId);
        if (product != null) {
          cartItemsList.add(
            domain_entity.CartItem(
              product: product,
              quantity: cartItem.quantity,
            ),
          );
        }
      }

      return cartItemsList;
    } catch (e) {
      Logger.error('Failed to get cart items from local storage', error: e);
      rethrow;
    }
  }

  @override
  Future<void> addToCart(domain_entity.CartItem item) async {
    try {
      final existingItem = await (_database.select(_database.cartItems)
            ..where((c) => c.productId.equals(item.product.id)))
          .getSingleOrNull();

      if (existingItem != null) {
        final newQuantity = existingItem.quantity + item.quantity;
        await (_database.update(_database.cartItems)
              ..where((c) => c.productId.equals(item.product.id)))
            .write(
          CartItemsCompanion(
            quantity: Value(newQuantity),
          ),
        );
      } else {
        await _database.into(_database.cartItems).insert(
              CartItemsCompanion.insert(
                productId: item.product.id,
                quantity: item.quantity,
              ),
            );
        await _saveProductIfNotExists(item.product);
      }
    } catch (e) {
      Logger.error('Failed to add to cart in local storage', error: e);
      rethrow;
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    try {
      await (_database.delete(_database.cartItems)
            ..where((c) => c.productId.equals(productId)))
          .go();
    } catch (e) {
      Logger.error('Failed to remove from cart in local storage', error: e);
      rethrow;
    }
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    try {
      if (quantity <= 0) {
        await removeFromCart(productId);
      } else {
        await (_database.update(_database.cartItems)
              ..where((c) => c.productId.equals(productId)))
            .write(
          CartItemsCompanion(quantity: Value(quantity)),
        );
      }
    } catch (e) {
      Logger.error('Failed to update quantity in local storage', error: e);
      rethrow;
    }
  }

  @override
  Future<void> clearCart() async {
    try {
      await _database.delete(_database.cartItems).go();
    } catch (e) {
      Logger.error('Failed to clear cart in local storage', error: e);
      rethrow;
    }
  }

  Future<domain.Product?> _getProductById(int productId) async {
    try {
      final product = await (_database.select(_database.products)
            ..where((p) => p.id.equals(productId)))
          .getSingleOrNull();

      if (product == null) return null;

      return domain.Product(
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
    } catch (e) {
      Logger.error('Failed to get product by id from local storage', error: e);
      return null;
    }
  }

  Future<void> _saveProductIfNotExists(domain.Product product) async {
    try {
      final existing = await (_database.select(_database.products)
            ..where((p) => p.id.equals(product.id)))
          .getSingleOrNull();

      if (existing == null) {
        await _database.into(_database.products).insert(
              ProductsCompanion.insert(
                id: Value(product.id),
                title: product.title,
                price: product.price,
                description: product.description,
                category: product.category,
                image: product.image,
                ratingRate: Value(product.rating?.rate),
                ratingCount: Value(product.rating?.count),
              ),
            );
      }
    } catch (e) {
      Logger.error('Failed to save product in local storage', error: e);
    }
  }
}

