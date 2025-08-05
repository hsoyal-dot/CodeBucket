import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart' show AppColors1;
import 'package:leetsave/core/themes/app_textstyle.dart' show AppTextStyles1;
import 'package:leetsave/domain/entities/problem.dart';
import 'package:leetsave/presentation/home/widgets/bucket_section.dart';
import 'package:leetsave/presentation/home/widgets/link_section.dart';
import 'package:leetsave/presentation/home/widgets/user_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<BucketSectionState> bucketKey = GlobalKey();

  void refreshBuckets() {
    bucketKey.currentState?.fetchBucketsAndProblems();
  }

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
          LinkSection(onRefreshBuckets: refreshBuckets),
          // RIGHT SECTION
          BucketSection(),
        ],
      ),
    );
  }
}

class BucketTile extends StatelessWidget {
  final String name;
  final List<Problem> problems;

  const BucketTile({required this.name, required this.problems, super.key});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        name,
        style: AppTextStyles1.body.copyWith(fontWeight: FontWeight.bold),
      ),
      children: problems.map((problem) {
        final Uri uri = Uri.parse(problem.link);
        final website = uri.host.replaceAll('www.', '');

        return ListTile(
          title: Text(problem.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Website: $website'),
              Text('Tags: ${problem.tags.join(', ')}'),
            ],
          ),
          trailing: const Icon(Icons.open_in_new),
          onTap: () async {
            final Uri url = Uri.parse(problem.link);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Could not open the link')),
              );
            }
          },
        );
      }).toList(),
    );
  }
}
