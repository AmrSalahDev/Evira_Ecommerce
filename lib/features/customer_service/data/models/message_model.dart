import 'package:equatable/equatable.dart';
import 'package:evira_e_commerce/features/customer_service/domain/entities/message_entity.dart';

class MessageModel extends Equatable {
  final String id;
  final String content;
  final DateTime createdAt;
  final bool isUserMessage;

  const MessageModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isUserMessage,
  });

  @override
  List<Object?> get props => [id, content, createdAt, isUserMessage];

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isUserMessage: json['is_user_message'] as bool,
    );
  }

  Map<String, dynamic> toJson(String userId) {
    return {
      'content': content,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'is_user_message': isUserMessage,
    };
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      content: content,
      createdAt: createdAt,
      isUserMessage: isUserMessage,
    );
  }
}
