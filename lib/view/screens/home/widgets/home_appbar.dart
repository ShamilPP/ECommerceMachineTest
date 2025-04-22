import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../cart/carts_screen.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.black,
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.search, size: 25),
          // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SearchScreen())),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined, size: 25),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
        ),
      ],
    );
  }
}
