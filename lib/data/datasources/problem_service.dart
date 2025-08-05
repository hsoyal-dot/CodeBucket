import 'package:leetsave/domain/entities/problem.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class ProblemService {
  final _client = Supabase.instance.client;

  Future<void> addProblem({
    required String? bucketId,
    required String title,
    required String link,
    List<String> tags = const [],
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");

    await _client.from('problems').insert({
      'user_id': userId,
      'bucket_id': bucketId,
      'title': title,
      'link': link,
      'tags': tags,
    });
  }

  Future<List<Problem>> getProblems(String? bucketId) async {
    final response = await _client
        .from('problems')
        .select()
        .eq('bucket_id', bucketId!)
        .order('created_at', ascending: false);

    return (response as List).map((json) => Problem.fromJson(json)).toList();
  }
}