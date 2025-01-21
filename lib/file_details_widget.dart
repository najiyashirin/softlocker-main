import 'package:flutter/material.dart';
import 'delete_confirmation_dialog.dart';

class FileDetailsWidget extends StatelessWidget {
  final String fileName;
  final String fileSize;

  const FileDetailsWidget({
    super.key,
    required this.fileName,
    required this.fileSize,
  });

  void _openDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => DeleteConfirmationDialog(
        onDelete: () {
          Navigator.pop(context);
          // Add logic to delete the file
          debugPrint('File deleted: $fileName');
        },
        onCancel: () {
          Navigator.pop(context); // Close the dialog without any action
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 393),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _FileHeader(fileName: fileName, fileSize: fileSize),

          const SizedBox(height: 16),

          // Divider
          const Divider(
            color: Color(0xFFC4C4C4),
            thickness: 1,
            height: 32,
          ),

          // Action Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _FileActionItem(
                  icon: 'assets/share_icon.png',
                  label: 'Share',
                ),
                const SizedBox(height: 20),
                const _FileActionItem(
                  icon: 'assets/rename_icon.png',
                  label: 'Rename',
                ),
                const SizedBox(height: 20),
                const _FileActionItem(
                  icon: 'assets/move_icon.png',
                  label: 'Move',
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => _openDeleteDialog(context),
                  child: const _FileActionItem(
                    icon: 'assets/delete_icon.png',
                    label: 'Delete',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Header Widget
class _FileHeader extends StatelessWidget {
  final String fileName;
  final String fileSize;

  const _FileHeader({
    super.key,
    required this.fileName,
    required this.fileSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.translate(
          offset: const Offset(0, 5),
          child: const Icon(
            Icons.insert_drive_file,
            size: 45,
            color: Color(0xFF0071A5),
          ),
        ),
        const SizedBox(width: 19),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fileName,
              style: const TextStyle(
                color: Color(0xFF272643),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              fileSize,
              style: const TextStyle(
                color: Color(0x80272643),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Action Item Widget
class _FileActionItem extends StatelessWidget {
  final String icon;
  final String label;

  const _FileActionItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 20),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
