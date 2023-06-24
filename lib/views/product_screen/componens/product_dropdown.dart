import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/products_controller.dart';
import 'package:emart_seller/widgets/text_style.dart';

Widget productDropDown(
    hint, List<String> list, dropValue, ProductsController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropValue.value == "" ? null : dropValue.value,
        isExpanded: true,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == "Category") {
            controller.subCategoryValue.value = "";
            controller.populateSubCategory(newValue.toString());
          }
          dropValue.value = newValue.toString();
        },
      ),
    )
        .box
        .white
        .padding(const EdgeInsets.symmetric(horizontal: 4))
        .roundedSM
        .make(),
  );
}
