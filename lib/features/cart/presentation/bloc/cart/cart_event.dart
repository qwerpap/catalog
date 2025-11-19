import 'package:catalog/features/cart/domain/entities/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class CartLoadItems extends CartEvent {
  const CartLoadItems();
}

class CartAddItem extends CartEvent {
  const CartAddItem(this.item);

  final CartItem item;

  @override
  List<Object?> get props => [item];
}

class CartRemoveItem extends CartEvent {
  const CartRemoveItem(this.productId);

  final int productId;

  @override
  List<Object?> get props => [productId];
}

class CartUpdateQuantity extends CartEvent {
  const CartUpdateQuantity({
    required this.productId,
    required this.quantity,
  });

  final int productId;
  final int quantity;

  @override
  List<Object?> get props => [productId, quantity];
}

class CartClear extends CartEvent {
  const CartClear();
}

