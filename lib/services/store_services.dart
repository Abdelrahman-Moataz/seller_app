import 'package:emart_seller/const/const.dart';

class StoreServices {
  static getProfile(uid) {
    return fireStore
        .collection(vendorsCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessages(uid) {
    return fireStore
        .collection(chatsCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrders(uid) {
    return fireStore
        .collection(ordersCollection)
        .where('vendor_id', arrayContains: uid)
        .snapshots();
  }

  static getProducts(uid) {
    return fireStore
        .collection(productsCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  // static getPopularProducts(uid) {
  //   return fireStore
  //       .collection(productsCollection)
  //       .where('vendor_id', isEqualTo: uid)
  //       .orderBy('p_wishlist'.length);
  // }
}
