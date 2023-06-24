import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widgets/text_style.dart';

Widget customTextField(
    {label, hint, controller, isDesc = false, isPass = false, color = white}) {
  return TextFormField(
    controller: controller,
    obscureText: isPass,
    style: const TextStyle(color: white),
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: color),
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: lightGrey)),
  );
}
