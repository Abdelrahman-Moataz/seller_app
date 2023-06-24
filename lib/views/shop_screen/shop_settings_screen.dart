import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/widgets/custom_textfield.dart';
import 'package:emart_seller/widgets/loading_indecator.dart';

import '../../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(
            text: shopSettings,
            size: 16.0,
          ),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopAddress: controller.shopAddressController.text,
                        shopName: controller.shopNameController.text,
                        shopDesc: controller.shopDescController.text,
                        shopMobile: controller.shopMobileController,
                        shopWebSite: controller.shopWebSiteController,
                      );
                      VxToast.show(context, msg: "Shop details Updated");
                    },
                    child: normalText(
                      text: save,
                    ),
                  ),
          ],
        ),
        body: Column(
          children: [
            customTextField(
              label: shopName,
              hint: nameHint,
              controller: controller.shopNameController,
            ),
            10.heightBox,
            customTextField(
              label: address,
              hint: shopAddressHint,
              controller: controller.shopAddressController,
            ),
            10.heightBox,
            customTextField(
              label: mobile,
              hint: shopMobileHint,
              controller: controller.shopMobileController,
            ),
            10.heightBox,
            customTextField(
              label: webSite,
              hint: shopWebSiteHint,
              controller: controller.shopWebSiteController,
            ),
            10.heightBox,
            customTextField(
              isDesc: true,
              label: description,
              hint: shopDescHint,
              controller: controller.shopDescController,
            ),
          ],
        ),
      ),
    );
  }
}
