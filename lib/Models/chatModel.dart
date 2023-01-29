import 'package:flutter/cupertino.dart';

class ChatMessage{
  String messageContent;
  String messageType;
  String type;
  int precedence;
  ChatMessage({required this.messageContent, required this.messageType, required this.type, required this.precedence});
}