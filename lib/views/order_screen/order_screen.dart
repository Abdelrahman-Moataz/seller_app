import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/orders_controller.dart';
import 'package:emart_seller/views/order_screen/order_details.dart';
import 'package:emart_seller/widgets/loading_indecator.dart';
import 'package:intl/intl.dart' as intl;

import '../../services/store_services.dart';
import '../../widgets/appbar_widget.dart';
import '../../widgets/text_style.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrderController());

    return Scaffold(
      appBar: appBarWidget(orders),
      body: StreamBuilder(
        stream: StoreServices.getOrders(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();

                    return ListTile(
                      onTap: () {
                        Get.to(() => OrderDetails(
                              data: data[index],
                            ));
                      },
                      tileColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: purpleColor),
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
                                  text:
                                      intl.DateFormat().add_yMd().format(time),
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
                        text: "EG ${data[index]['total_amount']}",
                        color: purpleColor,
                        size: 16.0,
                      ),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
