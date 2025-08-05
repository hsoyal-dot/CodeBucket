class Problem {
  final String id;
  final String bucketId;
  final String userId;
  final String title;
  final String link;
  final List<String> tags;
  final DateTime createdAt;

  Problem({
    required this.id,
    required this.bucketId,
    required this.userId,
    required this.title,
    required this.link,
    required this.tags,
    required this.createdAt,
  });

  factory Problem.fromJson(Map<String, dynamic> json) {
    return Problem(
      id: json['id'] ?? '',
      bucketId: json['bucket_id'] ?? '',
      userId: json['user_id'] ?? '',
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ?? [],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}
