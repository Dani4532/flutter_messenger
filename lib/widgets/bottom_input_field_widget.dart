import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_messenger/domain/chat.dart';
import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:provider/provider.dart';

class BottomInputFieldWidget extends StatelessWidget {
  final Future<void> Function() didChangeDependencies;
  Timer timer;
  BottomInputFieldWidget(this.didChangeDependencies, this.timer,  {Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    var chatContorller = TextEditingController();
    var chatData = Provider.of<ChatList>(context);
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(20)),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: chatContorller,
                  decoration: new InputDecoration(
                    hintText: 'Create New Chat',
                  ),
                  onTap: (){

                      timer.cancel();

                  },
                  onSubmitted: (value) {
                    var dateNow = DateTime.now().day.toString() +"."+ DateTime.now().month.toString() +"."+ DateTime.now().year.toString();
                    chatData.addChat(Chat(value,dateNow,[]));
                    chatContorller.clear();
                    didChangeDependencies();
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
                  var dateNow = DateTime.now().day.toString() +"."+ DateTime.now().month.toString() +"."+ DateTime.now().year.toString();
                  chatData.addChat(Chat(chatContorller.text,dateNow, []));
                  chatContorller.clear();
                  didChangeDependencies();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
