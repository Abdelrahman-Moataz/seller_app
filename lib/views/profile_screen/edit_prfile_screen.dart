import 'dart:io';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controllers/profile_controller.dart';
import 'package:emart_seller/widgets/loading_indecator.dart';

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
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(
            text: editProfile,
            size: 16.0,
          ),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);

                      ///if image is not selected
                      if (controller.profileImPath.value.isNotEmpty) {
                        await controller.uploadProfileImage();
                        await controller.updateProfileImage(
                          imgUrl: controller.profileImageLink,
                        );

                        VxToast.show(context, msg: "Updated");
                        controller.isLoading(false);
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                        VxToast.show(context, msg: "Wrong one");
                        controller.isLoading(false);
                      }

                      /// if all password matched data base
                      if (controller.snapshotData['password'] ==
                          controller.oldPassController.text) {
                        await controller.changeAuthPassword(
                            email: controller.snapshotData['email'],
                            password: controller.oldPassController.text,
                            newPassword: controller.newPassController.text);
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.newPassController.text);
                        VxToast.show(context, msg: "Updated");
                      } else if (controller
                              .oldPassController.text.isEmptyOrNull &&
                          controller.newPassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            imgUrl: controller.profileImageLink,
                            name: controller.nameController.text,
                            password: controller.snapshotData['password']);
                      } else {
                        VxToast.show(context, msg: "type password to proccess");
                        controller.isLoading(false);
                      }
                    },
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
              /// if data image url and controller path is empty

              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImPath.isEmpty
                  ? Image.asset(
                      productImg,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()

                  ///if data is not empty but controller path in empty

                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImPath.isEmpty
                      ? Image.network(
                          controller.snapshotData['imageUrl'],
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()

                      /// else if controller path is not empty but data image url is

                      : Image.file(
                          File(controller.profileImPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),

              // Image.asset(
              //   productImg,
              //   width: 150,
              // ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: white),
                  onPressed: () {
                    controller.changeImage(context);
                  },
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
      ),
    );
  }
}
