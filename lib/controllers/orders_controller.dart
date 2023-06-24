import 'package:emart_seller/const/const.dart';

class OrderController extends GetxController {
  var orders = [];

  var confirmed = false.obs;
  var onDelivery = false.obs;
  var delivered = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeStatus({title, status, docID}) async {
    var store = fireStore.collection(ordersCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
