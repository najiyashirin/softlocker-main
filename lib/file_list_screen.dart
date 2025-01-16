import 'package:flutter/material.dart';
import 'storage_info.dart';
import 'navigation_bar.dart';

class FileListScreen extends StatelessWidget {
  final String folderName;

  const FileListScreen({Key? key, required this.folderName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Example list of files in the folder
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
              // Header Section with Back Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                          context); // Navigate back to HomeFolderScreen
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    folderName, // Displays the folder name dynamically
                    style: const TextStyle(
                      color: Color(0xFF51506B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const Spacer(flex: 2), // To align the title in the center
                ],
              ),
              const SizedBox(height: 20),

              // File List Section
              Expanded(
                child: files.isEmpty
                    ? const Center(
                        child: Text(
                          "No files found in this folder.",
                          style: TextStyle(
                            color: Color(0xFF51506B),
                            fontSize: 14,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: const Color(0xFFE1E1E1)),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x14000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.insert_drive_file,
                                  color: Color(0xFF0071A5),
                                  size: 36,
                                ),
                                title: Text(
                                  file['name']!,
                                  style: const TextStyle(
                                    color: Color(0xFF272643),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                subtitle: Text(
                                  file['size']!,
                                  style: const TextStyle(
                                    color: Color(0x80272643),
                                    fontSize: 14,
                                    fontFamily: 'Roboto',
                                  ),
                                ),
                                onTap: () {
                                  // Handle file click actions here (e.g., open file)
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),

              const SizedBox(height: 16),

              // Storage Widget
              const StorageWidget(),

              const SizedBox(height: 39),

              // Custom Navigation Bar
              const CustomNavigationBar(),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
