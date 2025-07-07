import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leetsave',
      theme: ThemeData.dark(useMaterial3: true),
      // home: const LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
