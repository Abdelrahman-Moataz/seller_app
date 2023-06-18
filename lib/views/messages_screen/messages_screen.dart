import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/messages_screen/chat_Screen.dart';
import 'package:emart_seller/widgets/text_style.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: purpleColor,
            )),
        backgroundColor: white,
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
              120,
              (index) => ListTile(
                onTap: () {
                  Get.to(() => const ChatScreen());
                },
                leading: const CircleAvatar(
                  backgroundColor: purpleColor,
                  child: Icon(
                    Icons.person,
                    color: white,
                  ),
                ),
                title: boldText(text: "User Name", color: fontGrey),
                subtitle:
                    normalText(text: "Last message.....", color: darkGrey),
                trailing: normalText(text: "10:45 PM", color: darkGrey),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
