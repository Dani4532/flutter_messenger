import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:flutter_messenger/domain/content.dart';

class Chat{
  String? id;
  String name;

  List<Content> content;


  Chat(this.name, this.content, [this.id]);

  Chat.fromJson(String id, Map<String,dynamic> json) : this(
      json['chatname'], ChatList().getContentList(json['messages']), id
  );

  Map<String,dynamic> toJson(){
    return {
      "chatname": name,
    };

  }

  void setContent(List<Content> content){
    this.content.addAll(content);
  }


}