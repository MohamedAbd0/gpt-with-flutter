import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../../model/text_completion_model.dart';
import '../config/global_config.dart';

class GPTController extends GetxController {


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


  createImagesGenerations(String query) async {
    try {

      /// adding my massage
      messages.add(TextCompletionData(text: searchTextController.text, index: 0, finishReason: "",isSendMassage: true,isImage: false));
      searchTextController.clear();
      _loading.value = true;
      update();

      final response = await http.post(
          Uri.parse("$baseURL/images/generations"),
          body: json.encode({
            "prompt": query,
            "n": 1,
            "size": "256x256"
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

        Map<String,dynamic> jsonDate = (json.decode(response.body));
        List<dynamic> list = jsonDate["data"];

        /// to add new message
        messages.add(TextCompletionData(
          text: list.first["url"],
          index: jsonDate["created"],
          isImage: true,
          isSendMassage: false,
          finishReason: ''
        ));
      }
      _loading.value = false;
      update();

    } catch (e) {
      print("e : ${e.toString()}");
      _loading.value = false;
    }
  }


  createImagesVariation(File file) async {
    try {

      /// adding my massage
      messages.add(TextCompletionData(text: file.path, index: 0, finishReason: "",isSendMassage: true,isImage: true));
      searchTextController.clear();
      _loading.value = true;
      update();

      final request = http.MultipartRequest('POST', Uri.parse("$baseURL/images/variations"),);

      request.files.add(await http.MultipartFile.fromPath('image',file.path));
      request.fields["n"]= "1" ;
      request.fields["size"]= "256x256" ;
      request.headers["Authorization"]  = 'Bearer $OPEN_AI_KEY';

      var streamedResponse = await request.send();
      Map<String,dynamic> responseData = json.decode(await streamedResponse.stream.bytesToString());

      if (streamedResponse.statusCode == 200) {
        List<dynamic> list = responseData["data"];

        /// to add new message
        messages.add(TextCompletionData(
            text: list.first["url"],
            index: responseData["created"],
            isImage: true,
            isSendMassage: false,
            finishReason: ''
        ));
      }

      _loading.value = false;
      update();

    } catch (e) {
      print("e : ${e.toString()}");
      _loading.value = false;
    }
  }

  editsImages(List<File> file) async {
    try {

      print("editsImages");
      /// adding my massage
      file.forEach((element) {
        messages.add(TextCompletionData(text: element.path, index: 0, finishReason: "",isSendMassage: true,isImage: true));
      });
      searchTextController.clear();
      _loading.value = true;
      update();

      final request = http.MultipartRequest('POST', Uri.parse("$baseURL/images/edits"),);

      request.files.add(await http.MultipartFile.fromPath('image',file.first.path));
      request.files.add(await http.MultipartFile.fromPath('mask',file.first.path));
      request.fields["n"]= "1" ;
      request.fields["size"]= "256x256" ;
      request.fields["prompt"]= "coding" ;


      request.headers["Authorization"]  = 'Bearer $OPEN_AI_KEY';

      var streamedResponse = await request.send();
      Map<String,dynamic> responseData = json.decode(await streamedResponse.stream.bytesToString());

      print("streamedResponse : ${streamedResponse.statusCode}");
      print("responseData : ${responseData}");
      if (streamedResponse.statusCode == 200) {
        List<dynamic> list = responseData["data"];

        /// to add new message
        messages.add(TextCompletionData(
            text: list.first["url"],
            index: responseData["created"],
            isImage: true,
            isSendMassage: false,
            finishReason: ''
        ));
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


