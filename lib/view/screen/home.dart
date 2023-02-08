import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'chat_image_view.dart';
import 'chat_text_view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.withOpacity(0.8),
        title: const Text("GPT Chat"),centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children:  [
            Expanded(child: InkWell(
              onTap: (){
                Get.to(const ChatTextView());
              },
              child: const Card(
                color: Colors.greenAccent,
                child: Center(child: Text("Chat Text",textScaleFactor: 4,)),
              ),
            )),
            Expanded(child: InkWell(
              onTap: (){
                Get.to(const ChatImageView());
              },
              child: const Card(
                color: Colors.blue,
                child: Center(child: Text("Chat Image",textScaleFactor: 4,)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
