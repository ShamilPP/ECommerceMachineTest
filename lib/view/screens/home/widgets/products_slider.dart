import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../../constants/app_colors.dart';
import '../../../../model/product.dart';
import '../../../../view_model/bloc/product_bloc/product_bloc.dart';
import '../../../../view_model/bloc/product_bloc/product_state.dart';
import '../../../widgets/loading_network_image.dart';
import '../../product/product_single_view.dart';

class ProductsSlider extends StatelessWidget {
  ProductsSlider({Key? key}) : super(key: key);

  final ValueNotifier<int> currentSlide = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductsState>(builder: (context, state) {
      if (state is ProductsSuccess) {
        currentSlide.value = 0;
        List<Product> products = state.products;
        return Column(
          children: [
            CarouselSlider.builder(
              options: CarouselOptions(
                //For Responsive Design
                aspectRatio: 2.1,
                viewportFraction: .8,
                onPageChanged: (index, reason) => currentSlide.value = index,
              ),
              itemCount: products.length < 5 ? products.length : 5,
              itemBuilder: (ctx, index, value) {
                return productCard(context, products[index]);
              },
            ),
            ValueListenableBuilder(
              valueListenable: currentSlide,
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    products.length < 5 ? products.length : 5,
                    (index) => Container(
                      width: 10,
                      height: 10,
                      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(value == index ? 0.9 : 0.4),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      } else if (state is ProductsLoading) {
        return SizedBox(
          height: 300,
          width: double.infinity,
          child: Center(child: SpinKitFadingCube(color: AppColors.primaryColor, size: 25)),
        );
      } else if (state is ProductsError) {
        return Center(child: Text(state.message));
      } else {
        return const SizedBox(); // Default fallback
      }
    });
  }

  Widget productCard(BuildContext context, Product productDetails) {
    final String heroTag = '${productDetails.docId}ProductSlider';
    Widget space = const SizedBox(height: 7);

    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(.4), blurRadius: 2, offset: const Offset(0, 2))],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
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
                const SizedBox(width: 20),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      space,
                      RatingBarIndicator(
                        rating: productDetails.rating,
                        itemCount: 5,
                        itemSize: 18,
                        unratedColor: Colors.amber.shade100,
                        itemBuilder: (context, index) => const Icon(Icons.star, color: Colors.amber),
                      ),
                    ],
                  ),
                )
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
