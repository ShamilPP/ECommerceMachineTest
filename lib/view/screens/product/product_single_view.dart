import 'package:e_commerce_machinetest/view/screens/product/widgets/cart_box.dart';
import 'package:e_commerce_machinetest/view/screens/product/widgets/image_slider.dart';
import 'package:e_commerce_machinetest/view/screens/product/widgets/product_details.dart';
import 'package:flutter/material.dart';

import '../../../model/product.dart';

class ProductSingleView extends StatelessWidget {
  final Product product;
  final String heroTag;

  const ProductSingleView({Key? key, required this.product, required this.heroTag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name), centerTitle: true),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //Images
                  ImageSlider(images: product.images, heroTag: heroTag),
                  // Product details (Included similar products)
                  ProductDetails(product: product),
                ],
              ),
            ),
          ),
          // Cart box on bottom
          CartBox(product: product),
        ],
      ),
    );
  }
}
