import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/controllers/gpt_controller.dart';
import '../widgets/list_view_chat_body.dart';
import '../widgets/search_text_field_widget.dart';

class ChatTextView extends StatelessWidget {
  const ChatTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GPTController>(
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green.withOpacity(0.8),
              title: const Text('GPT-Chat-Text'),
              centerTitle: true,
              actions: [
                if (controller.loading.value)
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
              ],
            ),
            body: Column(children: [
              ListViewChatBody(
                messages: controller.messages,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: SearchTextFieldWidget(
                    textEditingController: controller.searchTextController,
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      controller.getTextCompletion(
                          controller.searchTextController.text);
                    }),
              ),
            ]));
      },
    );
  }
}
