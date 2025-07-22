import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:leetsave/core/themes/app_textstyle.dart';
import 'package:leetsave/domain/entities/response_data.dart';
import 'package:leetsave/domain/usecases/fetch_response.dart';
import 'package:leetsave/presentation/home/widgets/save_bucket_dialog.dart';

class LinkSection extends StatefulWidget {
  const LinkSection({super.key});

  @override
  State<LinkSection> createState() => _LinkSectionState();
}

class _LinkSectionState extends State<LinkSection> {
  final TextEditingController _linkController = TextEditingController();
  bool isLoading = false;
  bool showResults = false;
  String? selectedField;

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
                AnimatedOpacity(
                  duration: Duration(milliseconds: 500),
                  opacity: 1,
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors1.surface,
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: AppColors1.primary),
                    ),
                    child: Center(
                      child: Text(
                        'Preview of:\n${_linkController.text.trim()}',
                        textAlign: TextAlign.center,
                        style: AppTextStyles1.body,
                      ),
                    ),
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
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => SaveBucketDialog(
                          existingBuckets: ['Binary Search', 'DP'], // dummy
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
                      child: const Text('Approach'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => selectedField = 'explanation'),
                      child: const Text('Explanation'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => selectedField = 'timeComplexity'),
                      child: const Text('Time Complexity'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          setState(() => selectedField = 'spaceComplexity'),
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
