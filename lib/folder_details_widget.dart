import 'package:flutter/material.dart';

class FolderDetailsScreen extends StatelessWidget {
  final String folderName;
  final int itemCount;
  final int folderSize;

  const FolderDetailsScreen({
    super.key,
    required this.folderName,
    required this.itemCount,
    required this.folderSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(2, 10, 2, 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _FolderHeader(folderName: folderName, folderSize: folderSize),

          // Divider
          const Divider(
            color: Color(0xFFC4C4C4),
            thickness: 1,
            height: 36,
          ),

          // Action Items
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _FolderActionItem(
                  icon: 'assets/share_icon.png',
                  label: 'Share',
                ),
                SizedBox(height: 20),
                _FolderActionItem(
                  icon: 'assets/rename_icon.png',
                  label: 'Rename',
                ),
                SizedBox(height: 20),
                _FolderActionItem(
                  icon: 'assets/delete_icon.png',
                  label: 'Delete',
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
class _FolderHeader extends StatelessWidget {
  final String folderName;
  final int folderSize;

  const _FolderHeader({
    super.key,
    required this.folderName,
    required this.folderSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Row(
        children: [
          Transform.translate(
            offset: const Offset(0, 5), // Moves the icon 5 pixels downward
            child: const Icon(
              Icons.folder,
              size: 45,
              color: Color(0xFF0071A5),
            ),
          ),
          const SizedBox(width: 19),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 41,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(79),
                ),
              ),
              const SizedBox(height: 28),
              Text(
                folderName,
                style: const TextStyle(
                  color: Color(0xFF272643),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '$folderSize MB',
                style: const TextStyle(
                  color: Color(0x80272643),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Action Item Widget
class _FolderActionItem extends StatelessWidget {
  final String icon;
  final String label;

  const _FolderActionItem({
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
