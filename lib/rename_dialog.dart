import 'package:flutter/material.dart';

class RenameDialog extends StatefulWidget {
  final String currentName;
  final Function(String) onRename;

  const RenameDialog({
    super.key,
    required this.currentName,
    required this.onRename,
  });

  @override
  State<RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<RenameDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 338,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Rename",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                fontFamily: 'Roboto',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
              ),
            ),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 113, 165, 1),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    widget.onRename(_controller.text);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: Color.fromRGBO(0, 113, 165, 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
