import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dec/models/message.dart';

void main() {
  group('Message Model', () {
    test('should create a Message instance with all required properties', () {
      final now = DateTime.now();
      final message = Message(
        id: '1',
        text: 'Hello',
        sender: 'Me',
        timestamp: now,
        isMe: true,
      );

      expect(message.id, '1');
      expect(message.text, 'Hello');
      expect(message.sender, 'Me');
      expect(message.timestamp, now);
      expect(message.isMe, true);
    });
  });
}