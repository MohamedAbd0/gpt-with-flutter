import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpt/view/screen/chat_text/chat_text_view.dart';
import 'core/binding/binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      title: 'Chat GPT -Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatTextView(),
    );
  }
}
