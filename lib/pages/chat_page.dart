import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:flutter_messenger/widgets/bottom_chat_input_widget.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  int index;


  ChatPage(this.index, {Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var chats = Provider.of<ChatList>(context).all;


    @override
    Future<void> changeDependencies() async {
      Timer.periodic(Duration(seconds: 5), (timer) {
        setState(() {
          Provider.of<ChatList>(context, listen: false).loadChats();
        });
        return timer.cancel();
      });
    }
    //Provider.of<ChatList>(context).loadChats();
    changeDependencies();
    return Scaffold(
      appBar: AppBar(
        title: Text(chats[widget.index].name),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: AssetImage('assets/img.png'),
              fit: BoxFit.fill,
            ),
          ),
          ListView.builder(
            itemBuilder: (context, index) => ChatBubble(
              clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),
              alignment: Alignment.topRight,
              backGroundColor: Colors.indigo,
              margin: EdgeInsets.only(top: 20),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Text(chats[this.widget.index].content[index].content, style: TextStyle(color: Colors.white, fontSize: 20),),
              ),
            ),
            itemCount: chats[this.widget.index].content.length,
            shrinkWrap: true,
          ),
          BottomChatInputWidget(chats[widget.index]),
        ],
      ),
    );
  }
}

/*
chats[this.index].content[index].content
 */
