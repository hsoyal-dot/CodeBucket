import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> _signInWithGoogle() async {
    await supabase.auth.signInWithOAuth(
      OAuthProvider.google,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.login),
          label: const Text('Sign in with Google'),
          onPressed: _signInWithGoogle,
        ),
      ),
    );
  }
}
