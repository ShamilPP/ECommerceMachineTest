import 'package:e_commerce_machinetest/view/screens/product/product_single_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../constants/app_colors.dart';
import '../../../../model/product.dart';
import '../../../../view_model/bloc/product_bloc/product_bloc.dart';
import '../../../../view_model/bloc/product_bloc/product_state.dart';
import '../../../widgets/loading_network_image.dart';

class SimilarProducts extends StatefulWidget {
  final Product product;

  const SimilarProducts({Key? key, required this.product}) : super(key: key);

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  int crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    //For Responsive Design
    var size = MediaQuery.of(context).size;
    if (size.height < size.width) crossAxisCount = size.width ~/ 200;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('Similar Products', style: TextStyle(fontSize: 19)),
        const SizedBox(height: 10),
        BlocBuilder<ProductBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsSuccess) {
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: state.products.length < crossAxisCount * 5 ? state.products.length : crossAxisCount * 5,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: .7,
                ),
                itemBuilder: (ctx, index) {
                  return productCard(context, state.products[index]);
                },
              );
            } else if (state is ProductsLoading) {
              return SizedBox(
                height: 300,
                width: double.infinity,
                child: Center(
                  child: SpinKitFadingCube(
                    color: AppColors.primaryColor,
                    size: 25,
                  ),
                ),
              );
            } else if (state is ProductsError) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return const SizedBox(); // Default fallback
            }
          },
        ),
      ],
    );
  }

  Widget productCard(BuildContext context, Product productDetails) {
    final String heroTag = '${productDetails.docId}SimilarProducts';
    Widget space = const SizedBox(height: 5);

    return Container(
      height: 280,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColors.primaryColor.withOpacity(.4), blurRadius: 2, offset: const Offset(0, 2))],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Hero(
                    tag: heroTag,
                    child: LoadingNetworkImage(
                      productDetails.images[0],
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
                  ),
                )),
                space,
                Text(productDetails.name, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 15, color: Colors.black)),
                space,
                Text(productDetails.description, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13, color: Colors.grey)),
                space,
                // Price
                Row(
                  children: [
                    Text(
                      '₹ ${productDetails.price - (productDetails.price * productDetails.discount ~/ 100)}',
                      style: TextStyle(color: Colors.red.shade900, fontSize: 18),
                    ),
                    const SizedBox(width: 5),
                    Text('${productDetails.discount}% off', style: const TextStyle(color: Colors.green, fontSize: 13)),
                  ],
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ProductSingleView(product: productDetails, heroTag: heroTag)));
          },
        ),
      ),
    );
  }
}
