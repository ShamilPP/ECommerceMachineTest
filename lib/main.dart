import 'package:e_commerce_machinetest/constants/app_strings.dart';
import 'package:e_commerce_machinetest/view/screens/splash/splash_screen.dart';
import 'package:e_commerce_machinetest/view_model/bloc/auth_bloc/auth_bloc.dart';
import 'package:e_commerce_machinetest/view_model/bloc/auth_bloc/auth_event.dart';
import 'package:e_commerce_machinetest/view_model/bloc/cart_bloc/cart_bloc.dart';
import 'package:e_commerce_machinetest/view_model/bloc/product_bloc/product_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'config/firebase_options.dart';
import 'constants/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()..add(AppStarted())),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp(
        title: AppStrings.appName,
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          scaffoldBackgroundColor: AppColors.backgroundColor,
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: AppColors.textColor),
            bodyMedium: TextStyle(color: AppColors.textColor),
          ),
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ).copyWith(
            secondary: AppColors.secondaryColor,
            error: AppColors.errorColor,
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.primaryColor,
            ),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
