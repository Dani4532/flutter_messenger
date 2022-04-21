import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_messenger/domain/chat.dart';
import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:flutter_messenger/domain/content.dart';
import 'package:provider/provider.dart';

class BottomChatInputWidget extends StatefulWidget {
  Chat chat;
  Timer timer;
  Future<void> Function() changeDependencies;

  BottomChatInputWidget(this.chat, this.timer, this.changeDependencies,
      {Key? key})
      : super(key: key);

  @override
  State<BottomChatInputWidget> createState() => _BottomChatInputWidgetState();
}

class _BottomChatInputWidgetState extends State<BottomChatInputWidget> {
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
                  onTap: () {
                    widget.timer.cancel();
                  },
                  onSubmitted: (value) {
                    if (chatController.text == '') {
                      return;
                    }
                    var timeString = DateTime.now().hour.toString() +
                        ':' +
                        DateTime.now().minute.toString();
                    Provider.of<ChatList>(context, listen: false)
                        .addContent(widget.chat, Content(value, timeString));
                    chatController.clear();
                    widget.changeDependencies();
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
                  if (chatController.text == '') {
                    return;
                  }
                  var timeString = DateTime.now().hour.toString() +
                      ':' +
                      DateTime.now().minute.toString();
                  Provider.of<ChatList>(context, listen: false).addContent(
                      widget.chat, Content(chatController.text, timeString));
                  chatController.clear();
                  widget.changeDependencies();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
