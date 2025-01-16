import 'package:flutter/material.dart';

class StorageWidget extends StatelessWidget {
  const StorageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 364),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Storage',
            style: TextStyle(
              color: Color(0xFF0071A5),
              fontSize: 24,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            '0 GB of 5 GB used',
            style: TextStyle(
              color: Color(0xD9000000),
              fontSize: 15,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            height: 7,
            decoration: BoxDecoration(
              color: const Color(0xFF94C9DD),
              borderRadius: BorderRadius.circular(100),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 50,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(59),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            constraints: const BoxConstraints(maxWidth: 209),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFD9D9D9)),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 0,
                  color: Color(0x05000000),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: const Center(
              child: Text(
                'Cloud storage settings',
                style: TextStyle(
                  color: Color(0xD9000000),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
