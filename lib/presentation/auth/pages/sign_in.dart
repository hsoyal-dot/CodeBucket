import 'package:flutter/material.dart';
import 'package:leetsave/common/widgets/bg_video.dart';
import 'package:leetsave/core/themes/app_textstyle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});
  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> _signInWithGoogle() async {
    await supabase.auth.signInWithOAuth(OAuthProvider.google);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const BackgroundVideo(),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Leetsave', style: AppTextStyles1.headingLarge),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text('Sign in with Google'),
                  onPressed: _signInWithGoogle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
