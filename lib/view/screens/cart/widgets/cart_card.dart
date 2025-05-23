import 'package:e_commerce_machinetest/view/screens/product/product_single_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../model/product.dart';
import '../../../widgets/buttons/expand_button.dart';
import '../../../widgets/loading_network_image.dart';

class CartCard extends StatelessWidget {
  final Product product;

  CartCard({Key? key, required this.product}) : super(key: key);

  final DateTime deliveryTime = DateTime.now().add(const Duration(days: 8));

  @override
  Widget build(BuildContext context) {
    final String heroTag = '${product.docId}CartScreen';
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ProductSingleView(product: product, heroTag: heroTag)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 12),
              child: Row(
                children: [
                  // Product image and qty
                  Column(
                    children: [
                      Hero(
                        tag: heroTag,
                        child: LoadingNetworkImage(
                          product.images[0],
                          height: 75,
                          width: 75,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Qty: 1'),
                    ],
                  ),

                  // Product details (right side of image)
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(product.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, color: Colors.black)),
                          SizedBox(height: 7),
                          Text(product.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                          SizedBox(height: 7),
                          // RatingBar
                          RatingBarIndicator(
                            rating: product.rating,
                            itemCount: 5,
                            itemSize: 18,
                            unratedColor: Colors.amber.shade100,
                            itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                          ),

                          SizedBox(height: 7),
                          // Price
                          Row(
                            children: [
                              Text(
                                '₹${product.price}',
                                style: const TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough, fontSize: 13),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '₹${product.price - (product.price * product.discount ~/ 100)}',
                                style: TextStyle(color: Colors.red.shade900, fontSize: 18),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _deliveryDate(),
            const SizedBox(height: 10),
            const Divider(thickness: 1, height: 0),
            IntrinsicHeight(
              child: Row(
                children: [
                  ExpandButton(
                      shape: RoundedRectangleBorder(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete, color: Colors.grey.shade700),
                          const SizedBox(width: 10),
                          Text(
                            'Remove',
                            style: TextStyle(color: Colors.grey.shade700),
                          )
                        ],
                      ),
                      onTap: () {}),
                  const VerticalDivider(thickness: 1, width: 0),
                  ExpandButton(
                    shape: RoundedRectangleBorder(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.electric_bolt, color: Colors.grey.shade700),
                        const SizedBox(width: 10),
                        Text(
                          'Buy this now',
                          style: TextStyle(color: Colors.grey.shade700),
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _deliveryDate() {
    final List<String> weeks = [
      "Mon",
      "Tue",
      "Wed",
      "Thu",
      "Fri",
      "Sat",
      "Sun",
    ];

    final List<String> mounts = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sept",
      "Oct",
      "Nov",
      "Dec",
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: 'Delivery by ${weeks[DateTime.now().weekday - 1]} ${mounts[DateTime.now().month - 1]} ${deliveryTime.day} | '),
            const TextSpan(
              text: '₹40',
              style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough),
            ),
            const TextSpan(
              text: ' Free delivery',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
