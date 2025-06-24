import 'package:flutter/foundation.dart';
import 'message.dart';

class ConversationModel extends ChangeNotifier {
  final List<Message> _messages = [];
  final List<Message> _issues = [];
  
  List<Message> get messages => List.unmodifiable(_messages);
  List<Message> get issues => List.unmodifiable(_issues);

  void addMessage(Message message) {
    _messages.add(message);
    
    // If the message is marked as an issue, add it to the issues list
    if (message.isIssue) {
      _issues.add(message);
    }
    
    notifyListeners();
  }

  void processUserInput(String text) {
    // Add the user message
    final userMessage = Message(
      text: text,
      type: MessageType.user,
      isIssue: !text.startsWith('/'), // Consider non-command messages as issues
    );
    addMessage(userMessage);

    // Process commands
    if (text.startsWith('/')) {
      _processCommand(text);
    } else {
      // For regular messages, just echo them back as a system response
      final response = Message(
        text: 'You said: $text',
        type: MessageType.system,
      );
      addMessage(response);
    }
  }

  void _processCommand(String command) {
    if (command.startsWith('/q ')) {
      _processQueryCommand(command.substring(3).trim());
    } else if (command == '/dwqdqwd') {
      // Handle the dwqdqwd test command
      final response = Message(
        text: 'Test command executed successfully',
        type: MessageType.system,
      );
      addMessage(response);
    } else {
      // Unknown command
      final response = Message(
        text: 'Unknown command: $command',
        type: MessageType.system,
      );
      addMessage(response);
    }
  }

  void _processQueryCommand(String query) {
    if (query == 'what was the last issue before this one') {
      _getLastIssueBeforeThis();
    } else {
      // Unknown query
      final response = Message(
        text: 'Unknown query: $query',
        type: MessageType.system,
      );
      addMessage(response);
    }
  }

  void _getLastIssueBeforeThis() {
    // Find the most recent issue
    if (_issues.isEmpty) {
      final response = Message(
        text: 'No issues found in the conversation.',
        type: MessageType.system,
      );
      addMessage(response);
      return;
    }
    
    if (_issues.length == 1) {
      final response = Message(
        text: 'This is the only issue in the conversation.',
        type: MessageType.system,
      );
      addMessage(response);
      return;
    }
    
    // Get the second-to-last issue (the last issue before the current one)
    final lastIssueBeforeThis = _issues[_issues.length - 2];
    
    final response = Message(
      text: 'The last issue before this one was: "${lastIssueBeforeThis.text}"',
      type: MessageType.system,
    );
    addMessage(response);
  }
}