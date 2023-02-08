import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/controllers/gpt_controller.dart';
import '../widgets/list_view_chat_body.dart';
import '../widgets/search_text_field_widget.dart';

class ChatImageView extends StatelessWidget {
  const ChatImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GPTController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green.withOpacity(0.8),
            title: const Text('GPT-Chat-Image'),
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
          body: Column(
            children: [
              ListViewChatBody(
                messages: controller.messages,
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          XFile? file = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (file != null) {
                            final croppedFile = await ImageCropper().cropImage(
                              sourcePath: file.path,
                              compressFormat: ImageCompressFormat.png,
                              cropStyle: CropStyle.circle,
                              compressQuality: 100,
                              uiSettings: [
                                AndroidUiSettings(
                                    toolbarTitle: 'Cropper',
                                    toolbarColor: Colors.deepOrange,
                                    toolbarWidgetColor: Colors.white,
                                    initAspectRatio:
                                        CropAspectRatioPreset.square,
                                    lockAspectRatio: false),
                              ],
                            );

                            if (croppedFile != null) {
                              controller.createImagesVariation(
                                File(
                                  croppedFile.path,
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(Icons.image)),
                    Expanded(
                      child: SearchTextFieldWidget(
                          textEditingController:
                              controller.searchTextController,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            controller.createImagesGenerations(
                                controller.searchTextController.text);
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  selectImage(controller) async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: file.path,
        compressFormat: ImageCompressFormat.png,
        cropStyle: CropStyle.circle,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
        ],
      );

      if (croppedFile != null) {
        controller.createImagesVariation(
          File(
            croppedFile.path,
          ),
        );
      }
    }
  }
}
