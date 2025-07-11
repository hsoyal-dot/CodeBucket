import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignedIn extends StatelessWidget {
  const SignedIn({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text('Welcome')),
      body: Center(
        child: user == null
            ? const Text('User not signed in.')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Signed in as: ${user.email}'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await Supabase.instance.client.auth.signOut();
                      Navigator.pushReplacementNamed(context, '/');
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
      ),
    );
  }
}
