import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/auth_controller.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/messages_screen/messages_screen.dart';
import 'package:emart_seller/views/profile_screen/edit_prfile_screen.dart';
import 'package:emart_seller/views/shop_screen/shop_settings_screen.dart';
import 'package:emart_seller/widgets/loading_indecator.dart';
import 'package:emart_seller/widgets/text_style.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: settings, size: 16.0),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(EditProfileScreen(
                    userName: controller.snapshotData['vendor_name'],
                  ));
                },
                icon: const Icon(Icons.edit)),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>()
                      .signupMethod(context: context);
                  VxToast.show(context, msg: "Logged out");
                  Get.offAll(() => const LoginScreen());
                },
                child: normalText(text: logout))
          ],
        ),
        body: FutureBuilder(
          future: StoreServices.getProfile(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              controller.snapshotData = snapshot.data!.docs[0];
              return Column(
                children: [
                  ListTile(
                    leading: controller.snapshotData['imageUrl'] == ''
                        ? Image.asset(
                            productImg,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(
                            controller.snapshotData['imageUrl'],
                            width: 100,
                            height: 100,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                    // leading: Image.asset(productImg)
                    //     .box
                    //     .roundedFull
                    //     .clip(Clip.antiAlias)
                    //     .make(),
                    title: boldText(
                        text: "${controller.snapshotData['vendor_name']}"),
                    subtitle:
                        normalText(text: "${controller.snapshotData['email']}"),
                  ),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                        profileButtonIcons.length,
                        (index) => ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const ShopSettings());
                                break;
                              case 1:
                                Get.to(() => const MessagesScreen());
                                break;
                            }
                          },
                          leading:
                              Icon(profileButtonIcons[index], color: white),
                          title: normalText(text: profileButtonTitles[index]),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ));
  }
}
