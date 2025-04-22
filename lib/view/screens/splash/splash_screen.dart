import 'package:e_commerce_machinetest/constants/app_images.dart';
import 'package:e_commerce_machinetest/view/screens/home/home_screen.dart';
import 'package:e_commerce_machinetest/view_model/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_machinetest/view_model/bloc/cart_bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/bloc/auth_bloc/auth_bloc.dart';
import '../../../view_model/bloc/auth_bloc/auth_state.dart';
import '../../../view_model/bloc/product_bloc/product_bloc.dart';
import '../../../view_model/bloc/product_bloc/product_event.dart';
import '../auth/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            // Load product and carts
            context.read<ProductBloc>().add(FetchProducts());
            context.read<CartBloc>().add(FetchCarts(state.user.id!));

            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
          } else if (state is AuthUnauthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        },
        child: Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Image.asset(AppImages.icon),
          ),
        ),
      ),
    );
  }
}
