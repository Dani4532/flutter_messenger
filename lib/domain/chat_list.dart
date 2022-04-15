import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_messenger/domain/chat.dart';
import 'package:flutter_messenger/domain/content.dart';
import 'package:http/http.dart' as http;

class ChatList with ChangeNotifier {
  List<Chat> _chats = [];

  List<Chat> get all {
    return [..._chats];
  }

  Future<void> loadChats() async {
    final uri = Uri.parse(
        'https://fluttermessenger-fbcc8-default-rtdb.firebaseio.com/chatList.json');
    final response = await http.get(uri);
    final body = jsonDecode(response.body) as Map<String, dynamic>;
      _chats = body.entries.map((e) => Chat.fromJson(e.key, e.value)).toList();
  }

  Future<void> addChat(Chat newChat) async {
    final uri = Uri.parse(
        'https://fluttermessenger-fbcc8-default-rtdb.firebaseio.com/chatList.json');
    final response = await http.post(uri, body: jsonEncode(newChat.toJson()));
    final body = jsonDecode(response.body);
    final id = body['name'];
    newChat.id = id;
    var timeString = DateTime.now().hour.toString() + ':' + DateTime.now().minute.toString();
    var content = Content('You created this Chat', timeString);
    final uriContent = Uri.parse('https://fluttermessenger-fbcc8-default-rtdb.firebaseio.com/chatList/$id/messages.json');
    final responseContent = await http.post(uriContent, body: jsonEncode(content.toJson()));
    final bodyContent = jsonDecode(responseContent.body);
    final contentId = bodyContent['name'];
    content.id = contentId;
    newChat.setContent([content]);
    _chats.add(newChat);
    loadChats();
    notifyListeners();
  }

  Future<void> addContent(Chat newChat, Content content) async{
    var id = newChat.id;
    final uriContent = Uri.parse('https://fluttermessenger-fbcc8-default-rtdb.firebaseio.com/chatList/$id/messages.json');
    final responseContent = await http.post(uriContent, body: jsonEncode(content.toJson()));
    final bodyContent = jsonDecode(responseContent.body);
    final contentId = bodyContent['name'];
    content.id = contentId;
    newChat.setContent([content]);
    this.loadChats();
    notifyListeners();
  }

List<Content> getContentList(Map<String, dynamic> json){
    return json.entries.map((e) => Content.fromJson(e.key, e.value)).toList();
  }

}
