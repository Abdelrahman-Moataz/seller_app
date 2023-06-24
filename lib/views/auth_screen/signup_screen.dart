import '../../const/const.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/our_button.dart';
import '../home_screen/home.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            10.heightBox,
            "Join the $appName".text.white.size(18).make(),
            15.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      label: "Name",
                      hint: nameHint,
                      controller: controller.nameController,
                      isPass: false),
                  customTextField(
                      label: "Email",
                      hint: emailHint,
                      controller: controller.emailController,
                      isPass: false),
                  customTextField(
                      label: "Password",
                      hint: passwordHint,
                      controller: controller.passwordController,
                      isPass: true),
                  customTextField(
                      label: "Retype password",
                      hint: passwordHint,
                      controller: controller.passwordRetypeController,
                      isPass: true),
                  Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: red,
                            value: isCheck,
                            onChanged: (newValue) {
                              setState(() {
                                isCheck = newValue;
                              });
                            },
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                  text: "I agree to the ",
                                  style: TextStyle(color: white),
                                ),
                                TextSpan(
                                  text: "termsAndCon",
                                  style: TextStyle(color: white),
                                ),
                                TextSpan(
                                  text: " & ",
                                  style: TextStyle(color: white),
                                ),
                                TextSpan(
                                  text: "privacyPolicy",
                                  style: TextStyle(color: white),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),

                      5.heightBox,
                      //ourButton().box.width(context.screenWidth - 50).make(),

                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(red),
                            )
                          : ourButton(
                                  onPress: () async {
                                    if (isCheck != false) {
                                      controller.isLoading(true);
                                      try {
                                        await controller
                                            .signupMethod(
                                                context: context,
                                                email: controller
                                                    .emailController.text,
                                                password: controller
                                                    .passwordController.text)
                                            .then((value) {
                                          return controller.storeUserData(
                                              email: controller
                                                  .emailController.text,
                                              password: controller
                                                  .passwordController.text,
                                              name: controller
                                                  .nameController.text);
                                        }).then((value) {
                                          VxToast.show(context,
                                              msg: "logged In");
                                          Get.offAll(() => const Home());
                                        });
                                      } catch (e) {
                                        auth.signOut();
                                        VxToast.show(context,
                                            msg: e.toString());
                                        controller.isLoading(false);
                                      }
                                    }
                                  },
                                  color: isCheck == true ? red : lightGrey,
                                  title: "Sign up")
                              .box
                              .width(context.screenWidth - 50)
                              .make(),

                      10.heightBox,

                      //wrapping into gesture detector of velocity x

                      RichText(
                        text: const TextSpan(children: [
                          TextSpan(
                              text: "Already Have An Account   ",
                              style: TextStyle(
                                color: white,
                              )),
                          TextSpan(
                              text: login,
                              style: TextStyle(
                                color: red,
                              )),
                        ]),
                      ).onTap(() {
                        Get.to(() => const LoginScreen());
                      }),
                    ],
                  ),
                ],
              )
                  .box
                  .color(Colors.deepPurpleAccent)
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            ),
          ],
        ),
      ),
    );
  }
}
