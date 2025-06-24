import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chat_provider.dart';

class MessageInput extends StatefulWidget {
  const MessageInput({Key? key}) : super(key: key);

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  final _textController = TextEditingController();
  bool _isComposing = false;

  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;
    
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    
    Provider.of<ChatProvider>(context, listen: false).addMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              onChanged: (text) {
                setState(() {
                  _isComposing = text.trim().isNotEmpty;
                });
              },
              onSubmitted: _isComposing ? _handleSubmitted : null,
              decoration: const InputDecoration(
                hintText: 'Send a message',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(16),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: _isComposing
                ? () => _handleSubmitted(_textController.text)
                : null,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}