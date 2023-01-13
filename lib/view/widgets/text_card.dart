import 'package:flutter/material.dart';
import '../../core/constant/constant.dart';
import '../../model/text_completion_model.dart';

class TextCardWidget extends StatelessWidget {
  final TextCompletionData textCompletionData;
  const TextCardWidget({Key? key, required this.textCompletionData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: textCompletionData.isSendMassage ? Colors.green.withOpacity(0.05) : appColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all( 5),
      child: ListTile(
        leading: textCompletionData.isSendMassage ? const CircleAvatar(backgroundColor: Colors.green,child: Icon(Icons.person,color: Colors.white,),) : const CircleAvatar(child: Icon(Icons.ac_unit,),),
        title: Text(textCompletionData.text.trim(),),
      )
    );
  }
}

