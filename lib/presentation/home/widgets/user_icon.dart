// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show Supabase;

Widget get userIcon {
  final user = Supabase.instance.client.auth.currentUser;
  final userName = user?.userMetadata?['name'] ?? 'X';
  if (userName != null && userName.isNotEmpty) {
    return CircleAvatar(
      radius: 18,
      backgroundColor: AppColors1.background,
      child: Text(userName[0]),
    );
  } else {
    return CircleAvatar(radius: 18, child: Icon(Icons.account_circle_outlined));
  }
}
