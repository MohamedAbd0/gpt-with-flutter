import 'dart:io';

import 'package:flutter/material.dart';
import '../../../core/constant/constant.dart';
import '../../../model/chat_item.dart';

class ImageCardWidget extends StatelessWidget {
  final ChatItem chatItem;
  const ImageCardWidget({Key? key, required this.chatItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: chatItem.isSendMassage
                ? Colors.green.withOpacity(0.05)
                : appColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(5),
        child: ListTile(
          leading: chatItem.isSendMassage
              ? const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                )
              : const CircleAvatar(
                  child: Icon(
                    Icons.ac_unit,
                  ),
                ),
          title: chatItem.isSendMassage
              ? Image.file(
                  File(
                    chatItem.item,
                  ),
                )
              : Image.network(
                  chatItem.item,
                ),
        ));
  }
}
