import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controllers/chat_text_controller.dart';
import '../../widgets/search_text_field_widget.dart';
import '../../widgets/text_card.dart';


class ChatTextView extends StatelessWidget {
  const ChatTextView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatTextController>(
      builder: (controller){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green.withOpacity(0.8),
            title: const Text('GPT-Chat'),
            centerTitle: true,
            actions: [
              if(controller.loading.value)
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(color: Colors.white,),
                )
            ],
          ),
          body: Column(children: [

            Expanded(
              child: ListView.builder(
                itemCount: controller.messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return TextCardWidget ( textCompletionData: controller.messages[index] );
                },
              ),
            ),

            const SizedBox(height: 12),
            SearchTextFieldWidget(
                color: Colors.green.withOpacity(0.8),
                textEditingController: controller.searchTextController,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  controller.getTextCompletion(controller.searchTextController.text);
                }),
            const SizedBox(height: 20),
          ])
        );
      },
    );
  }
}
