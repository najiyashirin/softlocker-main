import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart'; // Import the PDF Viewer package

class PDFViewerScreen extends StatelessWidget {
  final String pdfPath; // Path to the PDF file

  const PDFViewerScreen({Key? key, required this.pdfPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PDF Viewer',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF0071A5),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 0.7,
          child: PDFView(
            filePath: pdfPath, // File path for the PDF
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: false,
            pageFling: true,
            onError: (error) {
              debugPrint(error.toString());
            },
            onRender: (pages) {
              debugPrint('PDF has $pages pages.');
            },
            onPageChanged: (page, total) {
              debugPrint('Page $page of $total');
            },
            onViewCreated: (controller) {
              debugPrint('PDF View created!');
            },
          ),
        ),
      ),
    );
  }
}
