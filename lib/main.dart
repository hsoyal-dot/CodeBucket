
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:leetsave/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // final url = dotenv.env['SUPABASE_URL'] ?? '';
  // final anonKey = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
  final url = "https://bzlhkenptoipqgjhjrdo.supabase.co";
  final anonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJ6bGhrZW5wdG9pcHFnamhqcmRvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE4OTkxMDAsImV4cCI6MjA2NzQ3NTEwMH0.6ddHzbmjFdPYznn2UUf6jath9gHxYceLHrrXmr7yr_o";
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url, anonKey: anonKey);
  // await dotenv.load();

  runApp(const MyApp());
}
