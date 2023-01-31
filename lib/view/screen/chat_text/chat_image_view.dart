import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/controllers/gpt_controller.dart';
import '../../widgets/search_text_field_widget.dart';
import '../../widgets/text_card.dart';


class ChatImageView extends StatelessWidget {
  const ChatImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GPTController>(
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
                  return
                    controller.messages[index].isImage ?
                    ImageCardWidget ( textCompletionData: controller.messages[index] ) :
                  TextCardWidget ( textCompletionData: controller.messages[index] );
                },
              ),
            ),

            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(onPressed:()async{

                  List<XFile>? file = await ImagePicker().pickMultiImage();
                  if(file!= null){

                    List<File> croppedFileList = [];

                    for (XFile element in file){
                      final croppedFile = await ImageCropper().cropImage(
                        sourcePath: element.path,
                        compressFormat: ImageCompressFormat.png,
                        cropStyle : CropStyle.circle,
                        compressQuality: 100,
                        uiSettings: [
                          AndroidUiSettings(
                              toolbarTitle: 'Cropper',
                              toolbarColor: Colors.deepOrange,
                              toolbarWidgetColor: Colors.white,
                              initAspectRatio: CropAspectRatioPreset.original,
                              lockAspectRatio: false),
                        ],
                      );
                      croppedFileList.add(File(croppedFile!.path));
                    }


                    if(croppedFileList.length == file.length){
                      await controller.editsImages(croppedFileList);

                    }

                  }

                }, icon: const Icon(Icons.add_photo_alternate_outlined)),

                IconButton(onPressed:()async{

                  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
                  if(file!= null){

                    final croppedFile = await ImageCropper().cropImage(
                      sourcePath: file.path,
                      compressFormat: ImageCompressFormat.png,
                      cropStyle : CropStyle.circle,
                      compressQuality: 100,
                      uiSettings: [
                        AndroidUiSettings(
                            toolbarTitle: 'Cropper',
                            toolbarColor: Colors.deepOrange,
                            toolbarWidgetColor: Colors.white,
                            initAspectRatio: CropAspectRatioPreset.original,
                            lockAspectRatio: false),
                      ],
                    );

                    if(croppedFile != null){
                      controller.createImagesVariation(File(croppedFile!.path));

                    }
                  }

                }, icon: const Icon(Icons.image)),
                Expanded(
                  child: SearchTextFieldWidget(
                      color: Colors.green.withOpacity(0.8),
                      textEditingController: controller.searchTextController,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        controller.createImagesGenerations(controller.searchTextController.text);
                      }),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ])
        );
      },
    );
  }

}
