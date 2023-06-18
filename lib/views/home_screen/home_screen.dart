import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/widgets/dashboard_button.dart';
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dashboardButton(context,
                    title: products, count: "60", icon: icProducts),
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
            ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(
                3,
                (index) => ListTile(
                  onTap: () {},
                  leading: Image.asset(productImg,
                      width: 100, height: 100, fit: BoxFit.cover),
                  title: boldText(text: "Product title", color: fontGrey),
                  subtitle: normalText(text: "EG 40.0", color: fontGrey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
