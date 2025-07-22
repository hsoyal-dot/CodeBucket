import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart' show AppColors1;
import 'package:leetsave/core/themes/app_textstyle.dart' show AppTextStyles1;
import 'package:leetsave/presentation/home/widgets/bucket_section.dart';
import 'package:leetsave/presentation/home/widgets/link_section.dart';
import 'package:leetsave/presentation/home/widgets/user_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors1.primary,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('CodeBucket', style: AppTextStyles1.appBarStyle),
            IconButton(
              icon: userIcon,
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // LEFT SECTION
          LinkSection(),

          // RIGHT SECTION
          BucketSection(),
        ],
      ),
    );
  }
}

class BucketTile extends StatelessWidget {
  final String name;
  final List<String> problems;

  const BucketTile({required this.name, required this.problems, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        name,
        style: AppTextStyles1.body.copyWith(fontWeight: FontWeight.bold),
      ),
      children: problems
          .map(
            (problem) => ListTile(
              title: Text(problem),
              onTap: () {
                // TODO: Open link in new tab (leetcode)
              },
            ),
          )
          .toList(),
    );
  }
}
