class Message {
  final String id;
  final String text;
  final String sender;
  final DateTime timestamp;
  final bool isMe;

  Message({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    required this.isMe,
  });
}