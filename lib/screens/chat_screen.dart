import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_input.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => ChatProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Chat'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (ctx, chatProvider, _) => chatProvider.messages.isEmpty
                    ? const Center(
                        child: Text('No messages yet. Start a conversation!'),
                      )
                    : ListView.builder(
                        reverse: true,
                        itemCount: chatProvider.messages.length,
                        itemBuilder: (ctx, i) {
                          final reversedIndex = chatProvider.messages.length - 1 - i;
                          final message = chatProvider.messages[reversedIndex];
                          return MessageBubble(message: message);
                        },
                      ),
              ),
            ),
            const MessageInput(),
          ],
        ),
      ),
    );
  }
}