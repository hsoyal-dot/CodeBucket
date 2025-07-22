import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  Future<void> _checkSession() async {
    final session = Supabase.instance.client.auth.currentSession;
    final expiresAt = session?.expiresAt;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      if (session != null && expiresAt != null && expiresAt * 1000 > DateTime.now().millisecondsSinceEpoch) {
        Navigator.pushReplacementNamed(context, '/signed_in');
      } else {
        // await Supabase.instance.client.auth.signOut();
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
