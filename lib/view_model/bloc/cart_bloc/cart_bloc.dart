import 'package:e_commerce_machinetest/services/remote/firestore/cart_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartFirestore _cartFirestore = CartFirestore();

  List<Cart> _carts = [];

  List<Cart> get carts => _carts;

  CartBloc() : super(CartInitial()) {
    on<FetchCarts>(_onFetchProducts);
    on<AddToCart>(_addToCart);
  }

  Future<void> _onFetchProducts(FetchCarts event, Emitter<CartState> emit) async {
    emit(CartLoading());

    try {
      var carts = await _cartFirestore.getAllCarts(event.userId);
      _carts = carts;
      emit(CartSuccess(carts));
    } catch (e) {
      emit(CartError("Failed to fetch carts: ${e.toString()}"));
    }
  }

  Future<void> _addToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      var cart = await _cartFirestore.addCart(event.cart);
      _carts.add(cart);
      emit(CartSuccess(_carts));
    } catch (e) {
      emit(CartError("Failed to fetch carts: ${e.toString()}"));
    }
  }
}
