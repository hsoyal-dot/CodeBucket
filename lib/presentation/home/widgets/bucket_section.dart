import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:leetsave/core/themes/app_textstyle.dart';
import 'package:leetsave/presentation/home/pages/home_page.dart';

class BucketSection extends StatefulWidget {
  const BucketSection({super.key});

  @override
  State<BucketSection> createState() => _BucketSectionState();
}

class _BucketSectionState extends State<BucketSection> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
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
          );
  }
}