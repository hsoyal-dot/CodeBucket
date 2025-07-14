import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:leetsave/core/themes/app_textstyle.dart';
import 'package:leetsave/presentation/home/widgets/save_bucket_dialog.dart';

class LinkSection extends StatefulWidget {
  const LinkSection({super.key});

  @override
  State<LinkSection> createState() => _LinkSectionState();
}

class _LinkSectionState extends State<LinkSection> {
  final TextEditingController _linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                labelStyle: TextStyle(color: AppColors1.primary),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Saved to \'$bucketName\'')),
                          );
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
    );
  }
}
