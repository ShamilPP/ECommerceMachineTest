import 'package:e_commerce_machinetest/model/product.dart';

abstract class ProductsState {
  const ProductsState();
}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsSuccess extends ProductsState {
  final List<Product> products;

  const ProductsSuccess(this.products);
}

class ProductsError extends ProductsState {
  final String message;

  const ProductsError(this.message);
}
