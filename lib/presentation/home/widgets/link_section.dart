import 'package:flutter/material.dart';
import 'package:leetsave/common/widgets/get_platform_icon.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:leetsave/core/themes/app_textstyle.dart';
import 'package:leetsave/data/datasources/bucket_service.dart';
import 'package:leetsave/domain/entities/response_data.dart';
import 'package:leetsave/domain/usecases/fetch_response.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:leetsave/presentation/home/widgets/save_bucket_dialog.dart';

class LinkSection extends StatefulWidget {
  final VoidCallback onRefreshBuckets;
  const LinkSection({super.key, required this.onRefreshBuckets});

  @override
  State<LinkSection> createState() => _LinkSectionState();
}

class _LinkSectionState extends State<LinkSection> {
  final TextEditingController _linkController = TextEditingController();
  bool isLoading = false;
  bool showResults = false;
  String? selectedField;

  List<String> getTags() {
    return cachedResponseData?.problemTags ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Paste your problem link:', style: AppTextStyles1.body),
              const SizedBox(height: 10),
              TextField(
                controller: _linkController,
                decoration: InputDecoration(
                  hintText: 'https://...',
                  hintStyle: AppTextStyles1.body,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide(color: AppColors1.primary),
                  ),
                  labelStyle: TextStyle(color: AppColors1.primary),
                ),
              ),
              const SizedBox(height: 20),

              if (showResults)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors1.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          getPlatformIcon(_linkController.text.trim()),
                          const SizedBox(width: 8),
                          Text(
                            Uri.tryParse(_linkController.text.trim())?.host ??
                                'Preview Unavailable',
                            style: AppTextStyles1.body.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: () async {
                          final uri = Uri.parse(_linkController.text.trim());
                          if (!await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          )) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to open link'),
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Open'),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20),

              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                        showResults = false;
                        selectedField = null;
                      });

                      final success = await fetchAndStoreResponse(
                        _linkController.text.trim(),
                      );

                      setState(() {
                        isLoading = false;
                        showResults = success;
                      });
                    },
                    style: AppTextStyles1.elevButtonNormal,
                    child: const Text('Search'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () async {
                      final buckets = await BucketService().getBuckets();
                      if (!context.mounted) return;

                      showDialog(
                        context: context,
                        builder: (_) => SaveBucketDialog(
                          existingBuckets: buckets.map((b) => b.name).toList(),
                          title: cachedResponseData?.title ?? 'Untitled',
                          link: _linkController.text.trim(),
                          tags: getTags(),
                          onSave: (bucketName) async {
                            if (!mounted) return;

                            widget.onRefreshBuckets();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Saved to \'$bucketName\''),
                              ),
                            );
                          },
                          onComplete: widget.onRefreshBuckets,
                        ),
                      );
                    },
                    style: AppTextStyles1.elevButtonOppNormal,
                    child: Text('Save', style: AppTextStyles1.body),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (isLoading) const CircularProgressIndicator(),

              if (showResults)
                Wrap(
                  spacing: 12,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => selectedField = 'approach'),
                      style: AppTextStyles1.elevButtonNormal,
                      child: const Text('Approach'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => selectedField = 'explanation'),
                      style: AppTextStyles1.elevButtonNormal,
                      child: const Text('Explanation'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => selectedField = 'timeComplexity'),
                      style: AppTextStyles1.elevButtonNormal,
                      child: const Text('Time Complexity'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => selectedField = 'spaceComplexity'),
                      style: AppTextStyles1.elevButtonNormal,
                      child: const Text('Space Complexity'),
                    ),
                  ],
                ),

              const SizedBox(height: 20),

              if (selectedField != null && cachedResponseData != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors1.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors1.primary),
                  ),
                  child: Text(
                    _getSelectedFieldText(cachedResponseData!, selectedField!),
                    style: AppTextStyles1.body,
                  ),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  String _getSelectedFieldText(ResponseData data, String field) {
    switch (field) {
      case 'approach':
        return data.approach;
      case 'explanation':
        return data.explanation;
      case 'timeComplexity':
        return data.timeComplexity;
      case 'spaceComplexity':
        return data.spaceComplexity;
      default:
        return '';
    }
  }
}
