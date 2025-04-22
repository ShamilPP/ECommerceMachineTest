import 'package:e_commerce_machinetest/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../view_model/bloc/auth_bloc/auth_bloc.dart';
import '../../../view_model/bloc/auth_bloc/auth_event.dart';
import '../../../view_model/bloc/auth_bloc/auth_state.dart';
import '../../../view_model/bloc/cart_bloc/cart_bloc.dart';
import '../../../view_model/bloc/cart_bloc/cart_event.dart';
import '../../../view_model/bloc/product_bloc/product_bloc.dart';
import '../../../view_model/bloc/product_bloc/product_event.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthAuthenticated) {
              // Navigate to the home screen after successful login
              // Load product and carts
              context.read<ProductBloc>().add(FetchProducts());
              context.read<CartBloc>().add(FetchCarts(state.user.id!));

              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomeScreen()), (predict) => false);
            } else if (state is AuthError) {
              // Show an error message if login fails
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150),
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(AppImages.icon),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: GoogleSignInButton(onPressed: () {
                    context.read<AuthBloc>().add(LoginWithGoogle());
                  })),
            ],
          ),
        ),
      ),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleSignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: const BorderSide(color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/google_logo.png', height: 24, width: 24),
          const SizedBox(width: 12),
          const Text(
            'Sign in with Google',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
