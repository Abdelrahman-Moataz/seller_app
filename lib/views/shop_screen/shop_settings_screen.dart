import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widgets/custom_textfield.dart';

import '../../widgets/text_style.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(
          text: shopSettings,
          size: 16.0,
        ),
        actions: [
          TextButton(
            onPressed: () {},
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
          ),
          10.heightBox,
          customTextField(
            label: address,
            hint: shopAddressHint,
          ),
          10.heightBox,
          customTextField(
            label: mobile,
            hint: shopMobileHint,
          ),
          10.heightBox,
          customTextField(
            label: webSite,
            hint: shopWebSiteHint,
          ),
          10.heightBox,
          customTextField(
            isDesc: true,
            label: description,
            hint: shopDescHint,
          ),
        ],
      ),
    );
  }
}
