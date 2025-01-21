import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'homefolderscreen.dart';

class CustomNavigationBar extends StatefulWidget {
  final bool isHomeSelected;

  const CustomNavigationBar({super.key, this.isHomeSelected = true});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool isHomeSelected = true;

  @override
  void initState() {
    super.initState();
    isHomeSelected = widget.isHomeSelected;
  }

  void _onHomeIconPressed(BuildContext context) {
    setState(() {
      isHomeSelected = true;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeFolderScreen()),
    );
  }

  void _onAddIconPressed(BuildContext context) {
    setState(() {
      isHomeSelected = false;
    });

    // Show the popup when Add button is pressed
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: _AddPopup(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 225,
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(140),
          boxShadow: const [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 15,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Home Icon
              GestureDetector(
                onTap: () => _onHomeIconPressed(context),
                child: Icon(
                  Icons.home,
                  color: const Color(0xFF0071A5),
                  size: isHomeSelected ? 36 : 30,
                ),
              ),

              // Add Icon
              GestureDetector(
                onTap: () => _onAddIconPressed(context),
                child: Container(
                  width: isHomeSelected ? 30 : 36,
                  height: isHomeSelected ? 30 : 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0071A5),
                    borderRadius: BorderRadius.circular(104),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddPopup extends StatelessWidget {
  const _AddPopup({super.key});

  void _selectFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      Navigator.pop(context); // Close the popup
      debugPrint('Selected from gallery: ${image.path}');
    }
  }

  void _openCamera(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      Navigator.pop(context); // Close the popup
      debugPrint('Captured with camera: ${image.path}');
    }
  }

  void _selectFile(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      Navigator.pop(context); // Close the popup
      debugPrint('Selected file: ${result.files.single.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          width: 271,
          height: 74,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(140),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 4,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _selectFromGallery(context),
                child: Image.asset(
                  'assets/gallery.png',
                  width: 36,
                  height: 36,
                ),
              ),
              GestureDetector(
                onTap: () => _openCamera(context),
                child: Image.asset(
                  'assets/camera.png',
                  width: 36,
                  height: 36,
                ),
              ),
              GestureDetector(
                onTap: () => _selectFile(context),
                child: Image.asset(
                  'assets/file_upload.png',
                  width: 36,
                  height: 36,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
