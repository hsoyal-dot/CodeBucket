import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:leetsave/domain/entities/response_data.dart';

ResponseData? cachedResponseData;

Future<bool> fetchAndStoreResponse(String link) async {
  final url = Uri.parse("http://192.0.0.2:8080/api/ask");

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'link': link}),
  );

  if (response.statusCode == 200) {
    cachedResponseData = ResponseData.fromJson(jsonDecode(response.body));
    return true;
  } else {
    print("Failed to fetch the response: ${response.body}");
    return false;
  }
}