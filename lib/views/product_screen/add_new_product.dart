import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widgets/custom_textfield.dart';

import '../../widgets/text_style.dart';
import 'componens/product_dropdown.dart';
import 'componens/product_images.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [TextButton(onPressed: () {}, child: boldText(text: save))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customTextField(hint: "BMW", label: "Product name"),
              10.heightBox,
              customTextField(
                  hint: "Nice product", label: "Description", isDesc: true),
              10.heightBox,
              customTextField(hint: "EG 100", label: "Price"),
              10.heightBox,
              customTextField(hint: "20", label: "Quantity"),
              10.heightBox,
              productDropDown(),
              10.heightBox,
              productDropDown(),
              10.heightBox,
              const Divider(color: white),
              boldText(text: "Choose product images"),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  3,
                  (index) => productImages(label: "${index + 1}"),
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
              Wrap(
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
                                .make(),
                            const Icon(
                              Icons.done,
                              color: white,
                            )
                          ],
                        )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
