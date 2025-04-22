import 'package:e_commerce_machinetest/view/screens/home/widgets/home_appbar.dart';
import 'package:e_commerce_machinetest/view/screens/home/widgets/products_list.dart';
import 'package:e_commerce_machinetest/view/screens/home/widgets/products_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBar(),
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text('Find your product', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
            ),
            const SizedBox(height: 10),
            ProductsSlider(),
            const ProductsList(),
          ],
        ),
      ),
    );
  }
}
