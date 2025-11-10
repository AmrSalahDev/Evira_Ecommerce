import 'package:evira_e_commerce/features/address/data/models/address_model.dart';
import 'package:evira_e_commerce/features/address/domain/datasource/address_remote_datasource.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton(as: AddressRemoteDatasource)
class AddressRemoteDatasourceImpl implements AddressRemoteDatasource {
  final supabase = Supabase.instance.client;

  @override
  Future<void> addAddress(AddressModel address) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return;
    await supabase.from('addresses').insert(address.toJson(userId));
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await supabase
        .from('addresses')
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List)
        .map((json) => AddressModel.fromJson(json))
        .toList();
  }
}
