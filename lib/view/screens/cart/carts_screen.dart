import 'package:e_commerce_machinetest/view_model/bloc/cart_bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../constants/app_colors.dart';
import '../../../view_model/bloc/cart_bloc/cart_bloc.dart';
import '../../../view_model/bloc/product_bloc/product_bloc.dart';
import '../../../view_model/bloc/product_bloc/product_state.dart';
import 'widgets/cart_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: Center(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (ctx, state) {
            if (state is CartSuccess) {
              if (state.carts.isNotEmpty) {
                // Assuming ProductsBloc is used to fetch product details
                final productsState = context.read<ProductBloc>().state;
                if (productsState is ProductsSuccess) {
                  final products = productsState.products;

                  return ListView.builder(
                    itemCount: state.carts.length,
                    itemBuilder: (ctx, index) {
                      final cart = state.carts[index];
                      final product = products.firstWhere((p) => p.docId == cart.productId);
                      return CartCard(product: product);
                    },
                  );
                } else if (productsState is ProductsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return const Center(child: Text('Failed to load products.'));
                }
              } else {
                return const Center(child: Text('No carts'));
              }
            } else if (state is CartLoading) {
              return SizedBox(
                height: 300,
                width: double.infinity,
                child: Center(
                  child: SpinKitFadingCube(color: AppColors.primaryColor, size: 25),
                ),
              );
            } else if (state is CartError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
