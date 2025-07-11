import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:leetsave/core/themes/app_textstyle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignedIn extends StatelessWidget {
  const SignedIn({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final fullName = user?.userMetadata?['name']?.toString().trim();
    final firstName = (fullName != null && fullName.contains(' '))
        ? fullName.split(' ').first
        : fullName ?? '';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleTextStyle: AppTextStyles1.section,
        title: Text('Leetsave', textAlign: TextAlign.left),
      ),
      body: Center(
        child: user == null
            ? Text('User not signed in.', selectionColor: AppColors1.warning)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome, $firstName',
                    style: AppTextStyles1.headingLarge,
                  ),
                  const SizedBox(height: 20),
                  Text('Signed in as: ${user.email}'),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await Supabase.instance.client.auth.signOut();
                          Navigator.pushReplacementNamed(context, '/');
                        },
                        style: AppTextStyles1.elevButtonRed,
                        child: const Text('Sign Out'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: () async {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        style: AppTextStyles1.elevButtonNormal,
                        label: const Text('Let\'s Dive In'),
                        icon: Icon(Icons.arrow_right_rounded),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
