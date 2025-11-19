import 'package:catalog/features/cart/domain/entities/cart_item.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  const CartLoaded({
    required this.items,
  });

  final List<CartItem> items;

  double get totalPrice {
    return items.fold<double>(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );
  }

  int get totalItems {
    return items.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );
  }

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  const CartError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

