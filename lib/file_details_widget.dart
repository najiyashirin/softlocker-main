import 'package:flutter/material.dart';

class FileDetailsScreen extends StatelessWidget {
  final String folderName;
  final int itemCount;
  final int folderSize;

  const FileDetailsScreen({
    Key? key,
    required this.folderName,
    required this.itemCount,
    required this.folderSize,
  }) : super(key: key);

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
          _FileHeader(folderName: folderName, folderSize: folderSize),

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
                _FileActionItem(
                  icon: 'assets/share_icon.png',
                  label: 'Share',
                ),
                SizedBox(height: 20),
                _FileActionItem(
                  icon: 'assets/rename_icon.png',
                  label: 'Rename',
                ),
                SizedBox(height: 20),
                _FileActionItem(
                  icon: 'assets/move_icon.png',
                  label: 'Move',
                ),
                SizedBox(height: 20),
                _FileActionItem(
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
class _FileHeader extends StatelessWidget {
  final String folderName;
  final int folderSize;

  const _FileHeader({
    Key? key,
    required this.folderName,
    required this.folderSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 13),
      child: Row(
        children: [
          Container(
            width: 41,
            height: 45,
            margin: const EdgeInsets.only(top: 22),
            decoration: BoxDecoration(
              color: const Color(0xFF0071A5),
              borderRadius: BorderRadius.circular(3),
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
class _FileActionItem extends StatelessWidget {
  final String icon;
  final String label;

  const _FileActionItem({
    Key? key,
    required this.icon,
    required this.label,
  }) : super(key: key);

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
