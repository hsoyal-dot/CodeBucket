import 'package:flutter/material.dart';
import 'package:leetsave/core/themes/app_colors.dart';
import 'package:leetsave/core/themes/app_textstyle.dart';

class SaveBucketDialog extends StatefulWidget {
  final List<String> existingBuckets;
  final Function(String bucketName) onSave;

  const SaveBucketDialog({
    super.key,
    required this.existingBuckets,
    required this.onSave,
  });

  @override
  State<SaveBucketDialog> createState() => _SaveBucketDialogState();
}

class _SaveBucketDialogState extends State<SaveBucketDialog> {
  String? selectedBucket;
  final TextEditingController _newBucketController = TextEditingController();
  bool isCreatingNew = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      backgroundColor: AppColors1.background,
      title: Text('Save to Bucket', style: AppTextStyles1.section),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.existingBuckets.isNotEmpty && !isCreatingNew) ...[
            DropdownButtonFormField<String>(
              value: selectedBucket,
              hint: Text('Select existing bucket', style: AppTextStyles1.body),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors1.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppColors1.secondary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              dropdownColor: AppColors1.surface,
              style: AppTextStyles1.body,
              items: widget.existingBuckets.map((bucket) {
                return DropdownMenuItem<String>(
                  value: bucket,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.list,
                        size: 18,
                        color: AppColors1.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(bucket, style: AppTextStyles1.body),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBucket = value;
                });
              },
            ),
            const SizedBox(height: 12),
          ],
          if (isCreatingNew)
            TextField(
              controller: _newBucketController,
              style: AppTextStyles1.body,
              decoration: InputDecoration(
                labelText: 'New bucket name',
                labelStyle: AppTextStyles1.body.copyWith(
                  color: AppColors1.secondary,
                ),
                filled: true,
                fillColor: AppColors1.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              isCreatingNew = !isCreatingNew;
              _newBucketController.clear();
            });
          },
          style: AppTextStyles1.elevButtonOppNormal,
          child: Text(
            isCreatingNew ? 'Use Existing Bucket' : 'Create New Bucket',
          ),
        ),
        // Cancel button
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: AppTextStyles1.elevButtonNormal,
          child: const Text('Quit'),
        ),
        // Save button
        ElevatedButton(
          onPressed: () {
            final bucket = isCreatingNew
                ? _newBucketController.text.trim()
                : selectedBucket;

            if (bucket != null && bucket.isNotEmpty) {
              if (isCreatingNew) {
                _showConfirmationDialog(bucket);
              } else {
                widget.onSave(bucket);
                Navigator.pop(context);
              }
            }
          },
          style: AppTextStyles1.elevButtonSuccess,
          child: const Text('Proceed'),
        ),
      ],
    );
  }

  Future<void> _showConfirmationDialog(String bucketName) async {
    String confirmationText = '';
    bool isError = false;
    final showBucketName = bucketName.substring(0, bucketName.length).toUpperCase();

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              title: Text(
                'Confirm Bucket Creation',
                style: AppTextStyles1.section,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Type "CREATE" to confirm'),
                  TextField(
                    style: AppTextStyles1.body,
                    cursorColor: AppColors1.primary,
                    onChanged: (value) {
                      confirmationText = value;
                      if (isError) setState(() => isError = false);
                    },
                  ),
                  if (isError)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Incorrect confirmation',
                        style: TextStyle(
                          color: AppColors1.danger,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: AppTextStyles1.elevButtonNormal,
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (confirmationText.trim().toUpperCase() == 'CREATE') {
                      widget.onSave(bucketName);
                      Navigator.pop(context); // close confirmation dialog
                      Navigator.pop(context); // close main dialog
                    } else {
                      setState(() => isError = true);
                    }
                  },
                  style: AppTextStyles1.elevButtonSuccess,
                  child: Text('Create \'$showBucketName\''),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
