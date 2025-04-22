import 'package:e_commerce_machinetest/view/screens/cart/carts_screen.dart';
import 'package:e_commerce_machinetest/view_model/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce_machinetest/view_model/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_machinetest/view_model/bloc/cart_bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/cart.dart';
import '../../../../model/product.dart';
import '../../../../view_model/bloc/cart_bloc/cart_event.dart';
import '../../../widgets/buttons/expand_button.dart';

class CartBox extends StatefulWidget {
  final Product product;

  const CartBox({Key? key, required this.product}) : super(key: key);

  @override
  State<CartBox> createState() => _CartBoxState();
}

class _CartBoxState extends State<CartBox> {
  bool isAlreadyCarted = false;

  @override
  Widget build(BuildContext context) {
    // check if item is already cart
    final cartState = context.read<CartBloc>().state;
    if (cartState is CartSuccess) {
      int cartIndex = cartState.carts.indexWhere((element) => element.productId == widget.product.docId);
      if (cartIndex != -1) isAlreadyCarted = true;
    }

    return Container(
      color: Colors.white,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ExpandButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onTap: isAlreadyCarted ? goToCart : addToCart,
              child: Text(isAlreadyCarted ? 'Go to cart' : 'Add to cart', style: TextStyle(color: Colors.black)),
            ),
            const SizedBox(width: 10),
            ExpandButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              onTap: () {},
              color: Colors.amber,
              child: const Text("Buy now", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void addToCart() async {
    var userId = BlocProvider.of<AuthBloc>(context).user!.id!;
    Cart cart = Cart(userId: userId, productId: widget.product.docId!, time: DateTime.now());
    BlocProvider.of<CartBloc>(context).add(AddToCart(cart));

    // Show snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Added to cart'),
        action: SnackBarAction(
          label: 'View',
          textColor: Colors.blue,
          onPressed: goToCart,
        ),
      ),
    );

    setState(() {
      isAlreadyCarted = true;
    });
  }

  void goToCart() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen()));
  }
}
