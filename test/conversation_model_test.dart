import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dec/models/conversation_model.dart';
import 'package:flutter_dec/models/message.dart';

void main() {
  group('ConversationModel', () {
    late ConversationModel model;

    setUp(() {
      model = ConversationModel();
    });

    test('should add a message to the conversation', () {
      final message = Message(text: 'Hello', type: MessageType.user);
      model.addMessage(message);
      
      expect(model.messages.length, 1);
      expect(model.messages.first.text, 'Hello');
    });

    test('should track issues separately', () {
      final issue = Message(text: 'This is an issue', type: MessageType.user, isIssue: true);
      model.addMessage(issue);
      
      expect(model.issues.length, 1);
      expect(model.issues.first.text, 'This is an issue');
    });

    test('should process user input and add response', () {
      model.processUserInput('Hello world');
      
      expect(model.messages.length, 2);
      expect(model.messages[0].text, 'Hello world');
      expect(model.messages[1].text, 'You said: Hello world');
    });

    test('should handle unknown commands', () {
      model.processUserInput('/unknown command');
      
      expect(model.messages.length, 2);
      expect(model.messages[1].text, 'Unknown command: /unknown command');
    });

    test('should handle unknown queries', () {
      model.processUserInput('/q unknown query');
      
      expect(model.messages.length, 2);
      expect(model.messages[1].text, 'Unknown query: unknown query');
    });

    test('should respond to "what was the last issue before this one" when no issues exist', () {
      model.processUserInput('/q what was the last issue before this one');
      
      expect(model.messages.length, 2);
      expect(model.messages[1].text, 'No issues found in the conversation.');
    });

    test('should respond to "what was the last issue before this one" with only one issue', () {
      model.processUserInput('First issue');
      model.processUserInput('/q what was the last issue before this one');
      
      expect(model.messages.length, 4);
      expect(model.messages[3].text, 'This is the only issue in the conversation.');
    });

    test('should respond to "/dwqdqwd" command', () {
      model.processUserInput('/dwqdqwd');
      
      expect(model.messages.length, 2);
      expect(model.messages[0].text, '/dwqdqwd');
      expect(model.messages[1].text, 'Test command executed successfully');
    });

    test('should respond to "what was the last issue before this one" with multiple issues', () {
      model.processUserInput('First issue');
      model.processUserInput('Second issue');
      model.processUserInput('/q what was the last issue before this one');
      
      expect(model.messages.length, 6);
      expect(model.messages[5].text, 'The last issue before this one was: "First issue"');
    });
  });
}