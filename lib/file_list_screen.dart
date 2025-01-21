import 'package:flutter/material.dart';
import 'storage_info.dart';
import 'navigation_bar.dart';
import 'file_details_widget.dart'; // Import the new file here

class FileListScreen extends StatelessWidget {
  final String folderName;

  const FileListScreen({super.key, required this.folderName});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> files = [
      {'name': 'Math Notes', 'size': '15 MB'},
      {'name': 'Physics Lab Report', 'size': '8 MB'},
      {'name': 'Chemistry Assignment', 'size': '12 MB'},
      {'name': 'Biology Presentation', 'size': '20 MB'},
      {'name': 'Computer Science Project', 'size': '25 MB'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 14, 17, 0),
          child: Column(
            children: [
              // Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back, size: 30),
                  ),
                  const Spacer(),
                  Text(
                    folderName,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
              const SizedBox(height: 20),

              // File List Section
              Expanded(
                child: files.isEmpty
                    ? const Center(
                        child: Text("No files found in this folder."))
                    : ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: GestureDetector(
                              onLongPress: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => FileDetailsWidget(
                                    fileName: file['name']!,
                                    fileSize: file['size']!,
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: ListTile(
                                  leading: const Icon(Icons.insert_drive_file,
                                      color: Colors.blue, size: 36),
                                  title: Text(file['name']!),
                                  subtitle: Text(file['size']!),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 16),
              const StorageWidget(),
              const SizedBox(height: 39),
              const CustomNavigationBar(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
