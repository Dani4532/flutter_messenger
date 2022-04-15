import 'package:flutter/material.dart';

class Content{
  String? id;
  String content;
  String time;

  Content(this.content, this.time, [this.id]);

  Content.fromJson(String id, Map<String,dynamic> json) : this(
      json['content'], json['time'], id
  );

  Map<String,dynamic> toJson(){
    return {
      "content": content,
      "time": time
    };
  }

}