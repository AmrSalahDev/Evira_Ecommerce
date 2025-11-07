import 'package:evira_e_commerce/features/customer_service/data/models/message_model.dart';
import 'package:evira_e_commerce/features/customer_service/domain/datasource/customer_service_remote_datasource.dart';
import 'package:evira_e_commerce/features/customer_service/domain/entities/message_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: CustomerServiceRemoteDatasource)
class CustomerServiceRemoteDatasourceImpl
    implements CustomerServiceRemoteDatasource {
  final supabase = Supabase.instance.client;

  @override
  Stream<List<MessageEntity>> getMessages() {
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      return Stream.value([]);
    }

    return supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at')
        .map(
          (maps) =>
              maps.map((map) => MessageModel.fromJson(map).toEntity()).toList(),
        );
  }

  @override
  Future<void> sendMessage({required MessageModel messageModel}) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;
    await supabase.from('messages').insert(messageModel.toJson(userId));
  }
}
