import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/cart.dart';

class CartFirestore {
  CollectionReference<Map<String, dynamic>> collection = FirebaseFirestore.instance.collection('carts');

  Future<List<Cart>> getAllCarts(String userId) async {
    List<Cart> carts = [];
    var allDocs = await collection.where('userId', isEqualTo: userId).get();
    for (var cart in allDocs.docs) {
      carts.add(Cart.fromDocument(cart));
    }
    return carts;
  }

  Future<Cart> addCart(Cart cart) async {
    var result = await collection.add(Cart.toMap(cart));
    cart.docId = result.id;
    return cart;
  }

  Future<bool> removeCart(Cart cart) async {
    await collection.doc(cart.docId).delete();
    return true;
  }
}
