import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_docs.png', // Replace with your empty state image asset
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
    );
  }
}
