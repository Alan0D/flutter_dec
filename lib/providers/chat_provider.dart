import 'package:flutter/foundation.dart';
import '../models/message.dart';

class ChatProvider with ChangeNotifier {
  final List<Message> _messages = [];
  
  List<Message> get messages => [..._messages];
  
  void addMessage(String text, {bool isMe = true}) {
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text,
      sender: isMe ? 'Me' : 'Other',
      timestamp: DateTime.now(),
      isMe: isMe,
    );
    
    _messages.add(newMessage);
    notifyListeners();
    
    // Simulate a response if the user sent a message
    if (isMe) {
      Future.delayed(const Duration(seconds: 1), () {
        addMessage('This is an automated response to: $text', isMe: false);
      });
    }
  }
}