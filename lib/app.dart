import 'package:flutter/material.dart';
import 'package:leetsave/presentation/auth/pages/sign_in.dart' show SignIn;
import 'package:leetsave/presentation/auth/pages/signed_in.dart';
import 'package:leetsave/presentation/splash_screen/pages/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leetsave',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/': (context) => SignIn(),
        '/signed_in': (context) => const SignedIn()
      }
    );
  }
}