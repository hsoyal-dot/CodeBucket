import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:leetsave/core/themes/app_textstyle.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    final name = user?.userMetadata?['name'];
    final email = user?.email;
    final createdAt = user?.createdAt.toString().substring(0, 10);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: AppTextStyles1.section),
        centerTitle: false,
        backgroundColor: AppColors1.background,
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: AppColors1.surface,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors1.secondary,
                  child: Text(
                    (name != null && name.isNotEmpty) ? name[0].toUpperCase() : 'U',
                    style: AppTextStyles1.heading.copyWith(
                      color: AppColors1.background,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(name, style: AppTextStyles1.heading),
                const SizedBox(height: 8),
                Text(
                  email!,
                  style: AppTextStyles1.body.copyWith(
                    color: AppColors1.secondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Member since: $createdAt",
                  style: AppTextStyles1.body.copyWith(
                    color: AppColors1.secondary,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  label: Text('Sign Out',),
                  onPressed: () async {
                    await Supabase.instance.client.auth.signOut();
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    }
                  },
                  style: AppTextStyles1.elevButtonRed,
                  icon: const Icon(Icons.logout),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
