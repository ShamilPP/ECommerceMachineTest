import 'package:e_commerce_machinetest/services/remote/firestore/product_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductFirestore _productFirestore = ProductFirestore();

  ProductBloc() : super(ProductsInitial()) {
    on<FetchProducts>(_onFetchProducts);
  }

  Future<void> _onFetchProducts(FetchProducts event, Emitter<ProductsState> emit) async {
    emit(ProductsLoading());

    try {
      var products = await _productFirestore.getAllProducts();
      emit(ProductsSuccess(products));
    } catch (e) {
      emit(ProductsError("Failed to fetch products: ${e.toString()}"));
    }
  }
}
