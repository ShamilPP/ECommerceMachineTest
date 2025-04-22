import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/product.dart';

class ProductFirestore {
  CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    var allDocs = await collection.get();
    for (var product in allDocs.docs) {
      products.add(Product.fromDocument(product));
    }
    return products;
  }
}
