import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/product_screen/product_details.dart';
import 'package:emart_seller/widgets/dashboard_button.dart';
import 'package:emart_seller/widgets/loading_indecator.dart';
import 'package:emart_seller/widgets/text_style.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: dashBoard, color: fontGrey, size: 16.0),
          actions: [
            Center(
              child: boldText(
                text: intl.DateFormat('EEE, MMM d, ' 'yy').format(
                  DateTime.now(),
                ),
                color: purpleColor,
              ),
            ),
            10.heightBox,
          ],
        ),
        body: StreamBuilder(
          stream: StoreServices.getProducts(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              data = data.sortedBy((a, b) =>
                  b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: products,
                            count: "${data.length}",
                            icon: icProducts),
                        dashboardButton(context,
                            title: orders, count: "15", icon: icOrder),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        dashboardButton(context,
                            title: rating, count: "50", icon: icStar),
                        dashboardButton(context,
                            title: totalSales, count: "14", icon: icOrder),
                      ],
                    ),
                    10.heightBox,
                    const Divider(),
                    10.heightBox,
                    boldText(text: popular, color: fontGrey, size: 16.0),
                    20.heightBox,
                    Expanded(
                      child: ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                          data.length,
                          (index) => data[index]['p_wishlist'].length == 0
                              ? const SizedBox()
                              : ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetails(
                                          data: data[index],
                                        ));
                                  },
                                  leading: Image.network(data[index][0],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGrey),
                                  subtitle: normalText(
                                      text: "EG ${data[index]['p_price']}",
                                      color: fontGrey),
                                ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
