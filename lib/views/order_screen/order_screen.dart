import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/order_screen/order_details.dart';
import 'package:intl/intl.dart' as intl;

import '../../widgets/appbar_widget.dart';
import '../../widgets/text_style.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(orders),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
              20,
              (index) => ListTile(
                onTap: () {
                  Get.to(() => const OrderDetails());
                },
                tileColor: textfieldGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: boldText(text: "901245856513546", color: purpleColor),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: fontGrey,
                        ),
                        10.widthBox,
                        boldText(
                            text: intl.DateFormat()
                                .add_yMd()
                                .format(DateTime.now()),
                            color: fontGrey),
                      ],
                    ),

                    Row(
                      children: [
                        const Icon(
                          Icons.payment,
                          color: fontGrey,
                        ),
                        10.widthBox,
                        boldText(text: unpaid, color: red),
                      ],
                    ),

                    //normalText(text: "EG 40.0", color: darkGrey),
                  ],
                ),
                trailing: boldText(
                  text: "EG 40.0",
                  color: purpleColor,
                  size: 16.0,
                ),
              ).box.margin(const EdgeInsets.only(bottom: 4)).make(),
            ),
          ),
        ),
      ),
    );
  }
}
