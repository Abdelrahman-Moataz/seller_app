import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/profile_controller.dart';

import '../../widgets/custom_textfield.dart';
import '../../widgets/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? userName;
  const EditProfileScreen({Key? key, this.userName}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var controller = Get.find<ProfileController>();
  @override
  void initState() {
    controller.nameController.text = widget.userName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(
          text: editProfile,
          size: 16.0,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: normalText(
              text: save,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.asset(
              productImg,
              width: 150,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
            10.heightBox,
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: white),
                onPressed: () {},
                child: normalText(text: changeImage, color: fontGrey)),
            10.heightBox,
            const Divider(
              color: white,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: boldText(text: "Change your Password")),
            10.heightBox,
            customTextField(
                label: name,
                hint: "Type your name",
                controller: controller.nameController),
            10.heightBox,
            customTextField(
                label: password,
                hint: passwordHint,
                controller: controller.oldPassController),
            10.heightBox,
            customTextField(
                label: confirmPassword,
                hint: passwordHint,
                controller: controller.newPassController),
          ],
        ),
      ),
    );
  }
}
