import 'package:flutter_messenger/domain/chat_list.dart';
import 'package:flutter_messenger/domain/content.dart';

class Chat{
  String? id;
  String name;
  String creation;
  List<Content> content;


  Chat(this.name, this.creation ,this.content, [this.id]);

  Chat.fromJson(String id, Map<String,dynamic> json) : this(
      json['chatname'], json['creation'], ChatList().getContentList(json['messages']), id
  );

  Map<String,dynamic> toJson(){
    return {
      "creation": creation,
      "chatname": name
    };

  }

  void setContent(List<Content> content){
    this.content.addAll(content);
  }


}