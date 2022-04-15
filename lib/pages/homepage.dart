import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:flutter_messenger/widgets/bottom_input_field_widget.dart';
import 'package:flutter_messenger/widgets/chat_list_widget.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    var chats = Provider.of<ChatList>(context).all;
    Provider.of<ChatList>(context).loadChats();
    Timer timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if(!mounted) return timer.cancel();
      setState(() {
        Provider.of<ChatList>(context, listen: false).loadChats();

        timer.cancel();
      });
    });

    @override
    Future<void> didChangeDependencies() async {
      if(timer.isActive) return timer.cancel();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
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
            itemBuilder: (context, index) =>
                ChatListWidget(index, didChangeDependencies, timer),
            shrinkWrap: true,
            itemCount: chats.length,
          ),
          BottomInputFieldWidget(didChangeDependencies, timer)
        ],
      ),
    );
  }
}
