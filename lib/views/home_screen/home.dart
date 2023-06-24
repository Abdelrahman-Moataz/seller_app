import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/home_controller.dart';
import 'package:emart_seller/views/home_screen/home_screen.dart';
import 'package:emart_seller/views/order_screen/order_screen.dart';
import 'package:emart_seller/views/product_screen/products_screen.dart';
import 'package:emart_seller/views/profile_screen/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const ProfileScreen()
    ];

    var bottomNavbar = [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
            size: 27,
          ),
          label: dashBoard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            width: 24,
            color: darkGrey,
          ),
          label: products),
      BottomNavigationBarItem(
        icon: Image.asset(
          icOrder,
          width: 24,
          color: darkGrey,
        ),
        label: orders,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icGeneralSettings,
          width: 24,
          color: darkGrey,
        ),
        label: settings,
      ),
    ];

    return Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: darkGrey,
            unselectedItemColor: darkGrey,
            items: bottomNavbar,
          ),
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: navScreens.elementAt(controller.navIndex.value),
              ),
            ],
          ),
        ));
  }
}
