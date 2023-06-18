import 'package:emart_seller/const/const.dart';

class StoreServices {
  static getProfile(uid) {
    return fireStore
        .collection(vendorsCollection)
        .where('id', isEqualTo: uid)
        .get();
  }
}
