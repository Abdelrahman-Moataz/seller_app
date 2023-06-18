import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widgets/text_style.dart';

Widget productDropDown() {
  return DropdownButtonHideUnderline(
    child: DropdownButton<String>(
      hint: normalText(text: "Choose Category", color: fontGrey),
      value: null,
      isExpanded: true,
      items: [],
      onChanged: (value) {},
    ),
  )
      .box
      .white
      .padding(const EdgeInsets.symmetric(horizontal: 4))
      .roundedSM
      .make();
}
