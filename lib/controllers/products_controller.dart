import 'dart:io';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';

import '../models/category_model.dart';

class ProductsController extends GetxController {
  var isLoading = false.obs;

  // Text field controller

  var pNameController = TextEditingController();
  var pDescController = TextEditingController();
  var pPriceController = TextEditingController();
  var pQuantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subCategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  var pImgsList = List<dynamic>.generate(3, (index) => null);

  var categoryValue = "".obs;
  var subCategoryValue = "".obs;
  var selectedColorIndex = 0.obs;

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubCategory(cat) {
    subCategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subCategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImgsList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImgsList) {
      if (item != null) {
        var fileName = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$fileName';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImgsList.add(n);
      }
    }
  }

  uploadProducts(context) async {
    var store = fireStore.collection(productsCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subCategoryValue.value,
      'p_colors': FieldValue.arrayUnion([Colors.red.value, Colors.brown.value]),
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_wishList': FieldValue.arrayUnion([]),
      'p_desc': pDescController.text,
      'p_name': pNameController.text,
      'p_price': pPriceController.text,
      'p_quantity': pQuantityController.text,
      'p_seller': Get.find<HomeController>().userName,
      'p_rating': "5.0",
      'vendor_id': currentUser!.uid,
      "featured_id": '',
    });
    isLoading(false);
    VxToast.show(context, msg: "Product uploaded");
  }

  addFeatured(docId) async {
    await fireStore.collection(productsCollection).doc(docId).set({
      'featured_id': currentUser!.uid,
      'is_featured': true,
    }, SetOptions(merge: true));
  }

  removeFeatured(docId) async {
    await fireStore.collection(productsCollection).doc(docId).set({
      'featured_id': "",
      'is_featured': false,
    }, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await fireStore.collection(productsCollection).doc(docId).delete();
  }
}
