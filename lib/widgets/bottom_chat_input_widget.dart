import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_messenger/domain/chat.dart';
import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:flutter_messenger/domain/content.dart';
import 'package:provider/provider.dart';

class BottomChatInputWidget extends StatelessWidget {
  Chat chat;

  BottomChatInputWidget(this.chat, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chatController = TextEditingController();

    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: chatController,
                  decoration: new InputDecoration(
                    hintText: 'Message',
                  ),
                  onSubmitted: (value) {
                    Provider.of<ChatList>(context, listen: false)
                        .addContent(chat, Content(value));
                    chatController.clear();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.send),
                onPressed: () {
                  Provider.of<ChatList>(context)
                      .addContent(chat, Content(chatController.text));
                  chatController.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
