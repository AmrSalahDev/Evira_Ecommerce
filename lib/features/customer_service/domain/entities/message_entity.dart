class MessageEntity {
  final String id;
  final String content;
  final DateTime createdAt;
  final bool isUserMessage;

  const MessageEntity({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isUserMessage,
  });
}
