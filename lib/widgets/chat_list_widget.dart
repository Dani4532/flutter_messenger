import 'package:flutter/material.dart';
import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:flutter_messenger/pages/chat_page.dart';
import 'package:provider/provider.dart';

class ChatListWidget extends StatelessWidget {
  final int index;
  Future<void> Function() didChangeDependencies;
  ChatListWidget(this.index, this.didChangeDependencies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chats = Provider.of<ChatList>(context).all;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ChatPage(index),
            ));
          },
          child: SizedBox(
            height: 60,
            width: 550,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          chats[index].content.length.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        chats[index].name,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
