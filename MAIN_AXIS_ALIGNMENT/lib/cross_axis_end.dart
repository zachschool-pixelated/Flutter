import 'package:flutter/material.dart';

class CrossAxisAlignmentEndScreen extends StatelessWidget {
  const CrossAxisAlignmentEndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF4FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00897B),
        centerTitle: true,
        title: const Text(
          'TASK 3 - ALIGNMENTS',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'CrossAxisAlignment.end',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Container(width: 65, height: 65, color: const Color(0xFFF44336)),
            Container(width: 65, height: 65, color: const Color(0xFFFFEB3B)),
            Container(width: 65, height: 65, color: const Color(0xFF2196F3)),
          ],
        ),
      ),
    );
  }
}
