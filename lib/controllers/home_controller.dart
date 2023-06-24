import 'package:emart_seller/const/const.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUserName();
  }

  var navIndex = 0.obs;
  var userName = "";

  getUserName() async {
    var n = await fireStore
        .collection(vendorsCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['vendor_name'];
      }
    });
    userName = n;
  }
}
