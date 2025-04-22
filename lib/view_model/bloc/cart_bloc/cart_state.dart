import '../../../model/cart.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<Cart> carts;

  const CartSuccess(this.carts);
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);
}
