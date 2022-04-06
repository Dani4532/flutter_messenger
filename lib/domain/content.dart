import 'package:flutter/material.dart';

class Content{
  String? id;
  String content;

  Content(this.content, [this.id]);

  Content.fromJson(String id, Map<String,dynamic> json) : this(
      json['content'], id
  );

  Map<String,dynamic> toJson(){
    return {
      "content": content
    };
  }

}