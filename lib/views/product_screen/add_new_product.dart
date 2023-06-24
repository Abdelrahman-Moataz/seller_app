import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/widgets/custom_textfield.dart';
import 'package:emart_seller/widgets/loading_indecator.dart';

import '../../widgets/text_style.dart';
import 'componens/product_dropdown.dart';
import 'componens/product_images.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: boldText(text: "Add product", size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      controller.uploadImages();
                      await controller.uploadProducts(context);

                      Get.back();
                    },
                    child: boldText(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "BMW",
                    label: "Product name",
                    controller: controller.pNameController),
                10.heightBox,
                customTextField(
                    hint: "Nice product",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pDescController),
                10.heightBox,
                customTextField(
                    hint: "EG 100",
                    label: "Price",
                    controller: controller.pPriceController),
                10.heightBox,
                customTextField(
                    hint: "20",
                    label: "Quantity",
                    controller: controller.pQuantityController),
                10.heightBox,
                productDropDown("Category", controller.categoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                productDropDown("Subcategory", controller.subCategoryList,
                    controller.subCategoryValue, controller),
                10.heightBox,
                const Divider(color: white),
                boldText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      3,
                      (index) => controller.pImgsList[index] != null
                          ? Image.file(
                              controller.pImgsList[index],
                              width: 100,
                            ).onTap(() {
                              controller.pickImage(index, context);
                            })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            }),
                    ),
                  ),
                ),
                10.heightBox,
                normalText(
                    text: "First Image will be your display Image",
                    color: lightGrey),
                const Divider(color: white),
                10.heightBox,
                boldText(text: "Choose product colors"),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        9,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .color(Vx.randomPrimaryColor)
                                    .roundedFull
                                    .size(50, 50)
                                    .make()
                                    .onTap(() {
                                  controller.selectedColorIndex.value = index;
                                }),
                                controller.selectedColorIndex.value == index
                                    ? const Icon(
                                        Icons.done,
                                        color: white,
                                      )
                                    : const SizedBox()
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
