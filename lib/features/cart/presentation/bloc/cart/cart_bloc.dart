import 'package:catalog/core/services/logger.dart';
import 'package:catalog/features/cart/domain/repositories/cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    required CartRepository cartRepository,
  })  : _cartRepository = cartRepository,
        super(const CartInitial()) {
    on<CartLoadItems>(_onLoadItems);
    on<CartAddItem>(_onAddItem);
    on<CartRemoveItem>(_onRemoveItem);
    on<CartUpdateQuantity>(_onUpdateQuantity);
    on<CartClear>(_onClear);
  }

  final CartRepository _cartRepository;

  Future<void> _onLoadItems(
    CartLoadItems event,
    Emitter<CartState> emit,
  ) async {
    emit(const CartLoading());
    try {
      final items = await _cartRepository.getCartItems();
      emit(CartLoaded(items: items));
    } catch (e) {
      Logger.error('Failed to load cart items', error: e);
      emit(CartError('Failed to load cart items: ${e.toString()}'));
    }
  }

  Future<void> _onAddItem(
    CartAddItem event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartRepository.addToCart(event.item);
      final items = await _cartRepository.getCartItems();
      emit(CartLoaded(items: items));
      Logger.info('Item added to cart');
    } catch (e) {
      Logger.error('Failed to add item to cart', error: e);
      if (state is CartLoaded) {
        emit(CartError('Failed to add item to cart: ${e.toString()}'));
      }
    }
  }

  Future<void> _onRemoveItem(
    CartRemoveItem event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartRepository.removeFromCart(event.productId);
      final items = await _cartRepository.getCartItems();
      emit(CartLoaded(items: items));
      Logger.info('Item removed from cart');
    } catch (e) {
      Logger.error('Failed to remove item from cart', error: e);
      if (state is CartLoaded) {
        emit(CartError('Failed to remove item from cart: ${e.toString()}'));
      }
    }
  }

  Future<void> _onUpdateQuantity(
    CartUpdateQuantity event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartRepository.updateQuantity(event.productId, event.quantity);
      final items = await _cartRepository.getCartItems();
      emit(CartLoaded(items: items));
      Logger.info('Cart item quantity updated');
    } catch (e) {
      Logger.error('Failed to update quantity', error: e);
      if (state is CartLoaded) {
        emit(CartError('Failed to update quantity: ${e.toString()}'));
      }
    }
  }

  Future<void> _onClear(
    CartClear event,
    Emitter<CartState> emit,
  ) async {
    try {
      await _cartRepository.clearCart();
      emit(const CartLoaded(items: []));
      Logger.info('Cart cleared');
    } catch (e) {
      Logger.error('Failed to clear cart', error: e);
      if (state is CartLoaded) {
        emit(CartError('Failed to clear cart: ${e.toString()}'));
      }
    }
  }
}

