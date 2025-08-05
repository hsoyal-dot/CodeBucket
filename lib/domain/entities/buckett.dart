class Buckett {
  final String? id;
  final String? userId;
  final String name;
  final DateTime? createdAt;

  Buckett({
    required this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
  });

  factory Buckett.fromJson(Map<String, dynamic> json) {

    if (json['id'] == null ||
        json['user_id'] == null ||
        json['name'] == null ||
        json['created_at'] == null) {
      throw Exception("Null is found in the bucket JSON: $json");
    }

    return Buckett(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      name: json['name'].toString(),
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}