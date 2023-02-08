import 'package:flutter/material.dart';
import '../../model/chat_item.dart';
import 'card/chat_card.dart';

class ListViewChatBody extends StatelessWidget {
  final List<ChatItem> messages;
  const ListViewChatBody({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (BuildContext context, int index) {
          return ChatItemCard(chatItem: messages[index]);
        },
      ),
    );
  }
}
