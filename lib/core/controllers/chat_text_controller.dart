import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../model/text_completion_model.dart';
import '../config/global_config.dart';

class ChatTextController extends GetxController {


  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<TextCompletionData> messages = [];


  getTextCompletion(String query) async {
    try {

      /// adding my massage
      messages.add(TextCompletionData(text: searchTextController.text, index: 0, finishReason: "",isSendMassage: true));
      searchTextController.clear();
      _loading.value = true;
      update();

      final response = await http.post(
        Uri.parse("$baseURL/completions"),
        body: json.encode({
            "model": "text-davinci-003",
            "prompt": query,
            }),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $OPEN_AI_KEY',
        }
      );
      if (kDebugMode) {
        print("Response : ${response.body}");
      }
      if (response.statusCode == 200) {

        /// to add new message
        messages.add(TextCompletionModel.fromJson(json.decode(response.body)).choices[0]);
      }
      _loading.value = false;
      update();

    } catch (e) {
      print("e : ${e.toString()}");
      _loading.value = false;
    }
  }

  TextEditingController searchTextController = TextEditingController();
}


