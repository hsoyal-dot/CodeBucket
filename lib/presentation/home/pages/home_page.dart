import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart' show AppColors1;
import 'package:leetsave/core/themes/app_textstyle.dart' show AppTextStyles1;
import 'package:leetsave/presentation/home/widgets/save_bucket_dialog.dart';
import 'package:leetsave/presentation/home/widgets/user_icon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors1.primary,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Leetsave', style: AppTextStyles1.appBarStyle),
            IconButton(
              icon: userIcon,
              onPressed: () {
                // TODO: navigate to profile
              },
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          // LEFT SECTION
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Paste your LeetCode link:', style: AppTextStyles1.body),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _linkController,
                    decoration: InputDecoration(
                      hintText: 'https://leetcode.com/problems/...',
                      hintStyle: AppTextStyles1.body,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: BorderSide(color: AppColors1.primary),
                      ),
                      labelStyle: TextStyle(color: AppColors1.primary)
                    ),
                  ),
                  const SizedBox(height: 20),

                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors1.surface,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: AppColors1.primary),
                    ),
                    child: const Center(
                      child: Text('LeetCode preview will appear here'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => SaveBucketDialog(
                              existingBuckets: ['Binary Search', 'DP'], // dummy data
                              onSave: (bucketName) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text('Saved to \'$bucketName\'')));
                              },
                            ),
                          );
                        },
                        style: AppTextStyles1.elevButtonOppNormal,
                        child: Text('Save', style: AppTextStyles1.body),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: Gemini API call 
                        },
                        style: AppTextStyles1.elevButtonNormal,
                        child: const Text('Find Approach'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // RIGHT SECTION
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16),
              color: AppColors1.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Buckets', style: AppTextStyles1.section),
                  const SizedBox(height: 16),
                  // TODO: Fetch from backned later
                  BucketTile(
                    name: 'Binary Search',
                    problems: [
                      'Search in Rotated Sorted Array',
                      'Find First and Last Position',
                    ],
                  ),
                  BucketTile(
                    name: 'Dynamic Programming',
                    problems: ['House Robber', 'Longest Palindromic Substring'],
                  ),
                ],
              ),
            ),
          ),
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