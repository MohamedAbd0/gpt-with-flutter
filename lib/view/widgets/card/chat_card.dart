import 'package:flutter/material.dart';

import '../../../model/chat_item.dart';
import 'image_card.dart';
import 'text_card.dart';

class ChatItemCard extends StatelessWidget {
  final ChatItem chatItem;
  const ChatItemCard({Key? key, required this.chatItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chatItem.isText
        ? TextCardWidget(
            chatItem: chatItem,
          )
        : ImageCardWidget(
            chatItem: chatItem,
          );
  }
}
