import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth import
import 'package:image_picker/image_picker.dart'; // Image Picker for camera/gallery
import 'dart:io'; // For working with File
import 'package:path/path.dart'; // For getting file name
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore
import 'file_screen.dart'; // FileScreen after saving

class EmptyState extends StatefulWidget {
  const EmptyState({super.key});

  @override
  _EmptyStateState createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  String _searchQuery = "";
  File? image; // Store the selected image
  final user =
      FirebaseAuth.instance.currentUser; // Get the current authenticated user
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Firestore instance

  // Sign-out function
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context as BuildContext,
        '/authentication/login1'); // Redirect to login screen after signing out
  }

  // Save document to Firestore
  Future<void> _saveDocumentToFirestore(BuildContext context) async {
    if (image == null || user == null) return;

    // Extract file name from the file path
    String fileName = basename(image!.path);

    // Save document details in Firestore
    await _firestore.collection('Documents').add({
      'fileName': fileName,
      'uploadedBy': user!.email,
      'uploadedAt': Timestamp.now(),
    }).then((_) {
      // Navigate to FileScreen after successfully saving the document
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const FileScreen()), // Navigate to FileScreen
      );
    }).catchError((error) {
      // Handle any errors
      print('Error saving document to Firestore: $error');
    });
  }

  // Pick image from the gallery
  Future<void> _pickImageFromGallery(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        _saveDocumentToFirestore(
            context); // Save the document after picking the image
      }
    });
  }

  // Capture image from the camera
  Future<void> _captureImageFromCamera(BuildContext context) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        _saveDocumentToFirestore(
            context); // Save the document after capturing the image
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signOut, // Sign-out action
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
            'assets/logo.png', // Add your logo path
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
                    hintText: "Search documents",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Empty State Icon and Message
              if (image == null) // Show empty state if no image is picked
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/empty_docs.png', // Empty state image asset
                      width: 179,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "You don't have any documents!",
                      style: TextStyle(
                        color: Color(0xFF51506B),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Scan or add your document by clicking the + button',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0x73272643),
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
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
                    onPressed: () =>
                        _pickImageFromGallery(context), // Pass context
                    child: const Icon(Icons.photo_library),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: () =>
                        _captureImageFromCamera(context), // Pass context
                    child: const Icon(Icons.camera_alt),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
