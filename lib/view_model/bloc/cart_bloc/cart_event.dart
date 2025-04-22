import '../../../model/cart.dart';

abstract class CartEvent {
  const CartEvent();
}

class FetchCarts extends CartEvent {
  final String userId;

  FetchCarts(this.userId);
}

class AddToCart extends CartEvent {
  final Cart cart;

  AddToCart(this.cart);
}
