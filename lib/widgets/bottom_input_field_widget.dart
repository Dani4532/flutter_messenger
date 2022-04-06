import 'package:flutter/material.dart';
import 'package:flutter_messenger/domain/chat.dart';
import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:provider/provider.dart';

class BottomInputFieldWidget extends StatelessWidget {
  const BottomInputFieldWidget( {Key? key}) : super(key: key);



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
                  onSubmitted: (value) {
                    chatData.addChat(Chat(value,[]));
                    chatContorller.clear();
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
                  chatData.addChat(Chat(chatContorller.text,[]));
                  chatContorller.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
