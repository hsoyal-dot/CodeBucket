import 'package:leetsave/domain/entities/buckett.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BucketService {
  final _client = Supabase.instance.client;

  Future<void> createBucket(String name) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");

    await _client.from('buckets').insert({'user_id': userId, 'name': name});
  }

  Future<List<Buckett>> getBuckets() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return [];

    final response = await _client
        .from('buckets')
        .select('id, user_id, name, created_at')
        .eq('user_id', userId)
        .order('created_at', ascending: false);

    return (response as List).map((json) => Buckett.fromJson(json)).toList();
  }
}
