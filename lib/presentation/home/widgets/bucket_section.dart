import 'package:flutter/material.dart';
import 'package:leetsave/data/datasources/bucket_service.dart';
import 'package:leetsave/data/datasources/problem_service.dart';
import 'package:leetsave/domain/entities/buckett.dart';
import 'package:leetsave/domain/entities/problem.dart';
import 'package:lottie/lottie.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:leetsave/core/themes/app_textstyle.dart';
import 'package:leetsave/presentation/home/pages/home_page.dart';

class BucketSection extends StatefulWidget {
  const BucketSection({super.key});

  @override
  State<BucketSection> createState() => BucketSectionState();
}

class BucketSectionState extends State<BucketSection> {
  final BucketService _bucketService = BucketService();
  List<Buckett> buckets = [];
  Map<String, List<Problem>> bucketProblems = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchBucketsAndProblems();
  }

  Future<void> fetchBucketsAndProblems() async {
    try {
      final result = await _bucketService.getBuckets();
      final Map<String, List<Problem>> problemsMap = {};
      for (final bucket in result) {
        final bucketId = bucket.id;
        final bucketName = bucket.name;

        try {
          final problems = await ProblemService().getProblems(bucketId);
          problemsMap[bucketName] = problems;
        } catch (e) {
          print(
            'Error getting problems for bucket $bucketName: $e',
          ); //debugging purpose
        }
      }

      setState(() {
        buckets = result;
        bucketProblems = problemsMap;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: AppColors1.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your Buckets', style: AppTextStyles1.section),
              const SizedBox(height: 16),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (buckets.isEmpty)
                Expanded(
                  child: Center(
                    child: Lottie.asset('assets/lottie/empty.json', width: 200),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: buckets.length,
                    itemBuilder: (context, index) {
                      final bucket = buckets[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: isMobile ? 8 : 12,
                          horizontal: isMobile ? 4 : 12,
                        ),
                        child: BucketTile(
                          name: bucket.name,
                          problems: (bucketProblems[bucket.name] ?? []),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
