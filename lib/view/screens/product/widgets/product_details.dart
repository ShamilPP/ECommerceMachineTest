import 'package:flutter/material.dart';

import '../../../../model/product.dart';
import 'similar_products.dart';

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade600, spreadRadius: 5, blurRadius: 7, offset: const Offset(0, 3)),
        ],
      ),
      child: Stack(
        children: [
          // Rating
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4)),
              child: Text(
                '${product.rating} ★',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                // Product name
                Text(product.name, style: const TextStyle(fontSize: 19)),
                const SizedBox(height: 5),
                // Price
                Row(
                  children: [
                    Text(
                      '₹${product.price}',
                      style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 17),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '₹${product.price - (product.price * product.discount ~/ 100)}',
                      style: const TextStyle(color: Colors.black, fontSize: 22),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${product.discount}% off',
                      style: const TextStyle(color: Colors.green, fontSize: 17),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                // Description
                Text(product.description, style: const TextStyle(color: Colors.grey, fontSize: 16)),

                // Similar Products
                SimilarProducts(product: product),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
