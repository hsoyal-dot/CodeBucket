class ResponseData {
  final String title;
  final String timeComplexity;
  final String spaceComplexity;
  final String explanation;
  final String approach;
  final List<String> problemTags;

  ResponseData({
    required this.title,
    required this.timeComplexity,
    required this.spaceComplexity,
    required this.explanation,
    required this.approach,
    this.problemTags = const [],
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) {
    return ResponseData(
      title: json['title'] ?? '',
      timeComplexity: json['timeComplexity'] ?? '',
      spaceComplexity: json['spaceComplexity'] ?? '',
      explanation: json['explanation'] ?? '',
      approach: json['approach'] ?? '',
      problemTags: List<String>.from(json['problemTags'] ?? []),
    );
  }
}