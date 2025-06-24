import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dec/providers/chat_provider.dart';

void main() {
  group('ChatProvider', () {
    test('should start with empty messages list', () {
      final chatProvider = ChatProvider();
      expect(chatProvider.messages.isEmpty, true);
    });

    test('should add a message when addMessage is called', () {
      final chatProvider = ChatProvider();
      chatProvider.addMessage('Hello', isMe: true);
      
      expect(chatProvider.messages.length, 1);
      expect(chatProvider.messages[0].text, 'Hello');
      expect(chatProvider.messages[0].isMe, true);
      expect(chatProvider.messages[0].sender, 'Me');
    });

    test('should add a message from another sender', () {
      final chatProvider = ChatProvider();
      chatProvider.addMessage('Hi there', isMe: false);
      
      expect(chatProvider.messages.length, 1);
      expect(chatProvider.messages[0].text, 'Hi there');
      expect(chatProvider.messages[0].isMe, false);
      expect(chatProvider.messages[0].sender, 'Other');
    });
  });
}