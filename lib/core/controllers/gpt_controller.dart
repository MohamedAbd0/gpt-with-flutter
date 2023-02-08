import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../model/text_completion_model.dart';
import '../../model/chat_item.dart';
import '../config/global_config.dart';

class GPTController extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<ChatItem> messages = [];

  void getTextCompletion(String query) async {
    try {
      /// adding my massage
      messages.add(
        ChatItem(
            item: searchTextController.text, isSendMassage: true, isText: true),
      );
      searchTextController.clear();
      _loading.value = true;
      update();

      final response = await http.post(Uri.parse("$baseURL/completions"),
          body: json.encode({
            "model": "text-davinci-003",
            "prompt": query,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $OPEN_AI_KEY',
          });
      if (kDebugMode) {
        print("Response : ${response.body}");
      }
      if (response.statusCode == 200) {
        /// to add new message

        for (TextCompletionData element
            in TextCompletionModel.fromJson(json.decode(response.body))
                .choices) {
          messages.add(
            ChatItem(item: element.text, isSendMassage: false, isText: true),
          );
        }
      }
      _loading.value = false;
      update();
    } catch (e) {
      _loading.value = false;
    }
  }

  createImagesGenerations(String query) async {
    try {
      /// adding my massage
      messages.add(
        ChatItem(
          item: searchTextController.text,
          isSendMassage: true,
          isText: true,
        ),
      );

      searchTextController.clear();
      _loading.value = true;
      update();

      final response = await http.post(Uri.parse("$baseURL/images/generations"),
          body: json.encode({"prompt": query, "n": 1, "size": "256x256"}),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $OPEN_AI_KEY',
          });
      if (kDebugMode) {
        print("Response : ${response.body}");
      }
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonDate = (json.decode(response.body));
        List<dynamic> list = jsonDate["data"];

        /// to add new message
        messages.add(
          ChatItem(
            item: list.first["url"],
            isSendMassage: false,
            isText: false,
          ),
        );
      }
      _loading.value = false;
      update();
    } catch (e) {
      log("e : ${e.toString()}");
      _loading.value = false;
    }
  }

  createImagesVariation(File file) async {
    try {
      /// adding my massage
      messages.add(
        ChatItem(
          item: file.path,
          isSendMassage: true,
          isText: false,
        ),
      );

      searchTextController.clear();
      _loading.value = true;
      update();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseURL/images/variations"),
      );

      request.files.add(await http.MultipartFile.fromPath('image', file.path));
      request.fields["n"] = "1";
      request.fields["size"] = "256x256";
      request.headers["Authorization"] = 'Bearer $OPEN_AI_KEY';

      var streamedResponse = await request.send();
      Map<String, dynamic> responseData =
          json.decode(await streamedResponse.stream.bytesToString());

      if (streamedResponse.statusCode == 200) {
        List<dynamic> list = responseData["data"];

        /// to add new message

        messages.add(
          ChatItem(
            item: list.first["url"],
            isSendMassage: false,
            isText: false,
          ),
        );
      }

      _loading.value = false;
      update();
    } catch (e) {
      log("e : ${e.toString()}");
      _loading.value = false;
    }
  }

  TextEditingController searchTextController = TextEditingController();
}
