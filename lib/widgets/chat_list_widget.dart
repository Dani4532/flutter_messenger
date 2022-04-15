import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:flutter_messenger/pages/chat_page.dart';
import 'package:provider/provider.dart';

class ChatListWidget extends StatelessWidget {
  final int index;
  Future<void> Function() didChangeDependencies;
  Timer timer;
  ChatListWidget(this.index, this.didChangeDependencies, this.timer, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chats = Provider.of<ChatList>(context).all;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            timer.cancel();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ChatPage(index),
            ));
          },
          child: Card(
            child: ListTile(
              trailing: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF76FF03),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    chats[index].content.length.toString(),
                    style: TextStyle(fontSize: 13, color: Color(0xFF00C853)),
                  ),
                ),
              ),
              title: Text(
                chats[index].name,
                style: TextStyle(fontSize: 20),
              ),
              subtitle: Text(
                chats[index].creation,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
