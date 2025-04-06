import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:image_picker/image_picker.dart'; // Image Picker for camera/gallery
import 'dart:io'; // For working with File
import 'empty_state.dart';
import 'profile_screen.dart'; // Import ProfileScreen

class HomeFolderScreen extends StatefulWidget {
  const HomeFolderScreen({super.key});

  @override
  _HomeFolderScreenState createState() => _HomeFolderScreenState();
}

class _HomeFolderScreenState extends State<HomeFolderScreen> {
  final List<Map<String, dynamic>> folders = [
    {'name': 'Medical', 'items': 0, 'size': 0},
    {'name': 'Education', 'items': 0, 'size': 0},
    {'name': 'ID Cards', 'items': 0, 'size': 0},
    {'name': 'ATM Cards', 'items': 0, 'size': 0},
    {'name': 'Certificate', 'items': 0, 'size': 0},
  ];

  String _searchQuery = "";
  File? image; // Store the selected image
  final user =
      FirebaseAuth.instance.currentUser; // Get the current authenticated user

  // Sign-out function
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context,
        '/authentication/login1.dart'); // Redirect to login screen after signing out
  }

  // Pick image from the gallery
  Future<void> _pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  // Capture image from the camera
  Future<void> _captureImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter folders based on search query
    List<Map<String, dynamic>> filteredFolders = folders.where((folder) {
      return folder["name"]!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            icon: const Icon(
              Icons.account_circle,
              size: 42,
              color: Color(0xFF0071A5),
            ),
          ),
          IconButton(
            onPressed: () {
              signOut(); // Call sign-out when clicked
            },
            icon: const Icon(
              Icons.logout,
              size: 24,
              color: Color(0xFF0071A5),
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Container(
          child: Image.asset(
            'assets/logo.png',
            width: 40,
            height: 33,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(color: Colors.grey, thickness: 1),
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(17, 14, 17, 0),
          child: Column(
            children: [
              // Display the authenticated user's email
              if (user != null)
                Text(
                  'Logged in as: ${user!.email}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),

              // Search Bar Section
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search folders",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Folder Grid Section
              Expanded(
                child: filteredFolders.isEmpty
                    ? const EmptyState()
                    : GridView.builder(
                        itemCount: filteredFolders.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16.0,
                          mainAxisSpacing: 16.0,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: (context, index) {
                          final folder = filteredFolders[index];
                          return GestureDetector(
                            onTap: () {
                              // Functionality for tapping on a folder
                              _showFolderOptions(context, folder['name']);
                            },
                            child: Column(
                              children: [
                                const Icon(
                                  Icons.folder,
                                  color: Color(0xFF0071A5),
                                  size: 50,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  folder['name'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0071A5),
                                  ),
                                ),
                                Text(
                                  "${folder['items']} items",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                Text(
                                  "${folder['size']} KB",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),

              // Show the picked image if available
              if (image != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: [
                      const Text(
                        "Selected Image:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Image.file(image!, height: 150),
                    ],
                  ),
                ),

              const SizedBox(height: 16),

              // Image Picker Floating Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: _pickImageFromGallery,
                    child: const Icon(Icons.photo_library),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: _captureImageFromCamera,
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),

              const SizedBox(height: 39),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // Show folder options on long press or tap
  void _showFolderOptions(BuildContext context, String folderName) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                folderName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text("Share"),
                onTap: () {
                  // Add share functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.drive_file_rename_outline),
                title: const Text("Rename"),
                onTap: () {
                  // Add rename functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder_open),
                title: const Text("Move"),
                onTap: () {
                  // Add move functionality
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title:
                    const Text("Delete", style: TextStyle(color: Colors.red)),
                onTap: () {
                  setState(() {
                    folders
                        .removeWhere((folder) => folder["name"] == folderName);
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
