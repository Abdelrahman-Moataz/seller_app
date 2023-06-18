import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/product_screen/add_new_product.dart';
import 'package:emart_seller/views/product_screen/product_details.dart';
import 'package:emart_seller/widgets/appbar_widget.dart';

import '../../widgets/text_style.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddProduct());
        },
        backgroundColor: purpleColor,
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: appBarWidget(products),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
              20,
              (index) => ListTile(
                onTap: () {
                  Get.to(() => const ProductDetails());
                },
                leading: Image.asset(productImg,
                    width: 100, height: 100, fit: BoxFit.cover),
                title: boldText(text: "Product title", color: fontGrey),
                subtitle: Row(
                  children: [
                    normalText(text: "EG 40.0", color: fontGrey),
                    10.widthBox,
                    boldText(text: "Featured", color: green),
                  ],
                ),
                trailing: VxPopupMenu(
                  arrowSize: 0.0,
                  menuBuilder: () => Column(
                    children: List.generate(
                      popupMenuTitles.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Icon(popupMenuIcons[index]),
                            10.widthBox,
                            normalText(
                                text: popupMenuTitles[index], color: darkGrey)
                          ],
                        ).onTap(() {}),
                      ),
                    ),
                  ).box.white.rounded.width(200).make(),
                  clickType: VxClickType.singleClick,
                  child: const Icon(Icons.more_vert_rounded),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
