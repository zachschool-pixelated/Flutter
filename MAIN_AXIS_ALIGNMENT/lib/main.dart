import 'package:flutter/material.dart';
import 'main_axis_start.dart';
import 'main_axis_center.dart';
import 'main_axis_end.dart';
import 'main_axis_space_between.dart';
import 'main_axis_space_around.dart';
import 'main_axis_space_evenly.dart';
import 'cross_axis_start.dart';
import 'cross_axis_center.dart';
import 'cross_axis_end.dart';
import 'cross_axis_stretch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 3 - Main & Cross Alignments',
      theme: ThemeData(
        useMaterial3: true,
      ),
      // To launch a specific alignment screen directly, replace AlignmentMenuScreen() below
      // e.g., home: const MainAxisAlignmentSpaceBetweenScreen(),
      home: const AlignmentMenuScreen(),
    );
  }
}

class AlignmentMenuScreen extends StatelessWidget {
  const AlignmentMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF4FC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00897B),
        centerTitle: true,
        title: const Text(
          'TASK 3 - ALIGNMENTS MENU',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainAxisAlignmentStartScreen()),
                  );
                },
                child: const Text('MainAxisAlignment.start'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainAxisAlignmentCenterScreen()),
                  );
                },
                child: const Text('MainAxisAlignment.center'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainAxisAlignmentEndScreen()),
                  );
                },
                child: const Text('MainAxisAlignment.end'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainAxisAlignmentSpaceBetweenScreen()),
                  );
                },
                child: const Text('MainAxisAlignment.spaceBetween'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainAxisAlignmentSpaceAroundScreen()),
                  );
                },
                child: const Text('MainAxisAlignment.spaceAround'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainAxisAlignmentSpaceEvenlyScreen()),
                  );
                },
                child: const Text('MainAxisAlignment.spaceEvenly'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrossAxisAlignmentStartScreen()),
                  );
                },
                child: const Text('CrossAxisAlignment.start'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrossAxisAlignmentCenterScreen()),
                  );
                },
                child: const Text('CrossAxisAlignment.center'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrossAxisAlignmentEndScreen()),
                  );
                },
                child: const Text('CrossAxisAlignment.end'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00897B),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CrossAxisAlignmentStretchScreen()),
                  );
                },
                child: const Text('CrossAxisAlignment.stretch'),
              ),
            ),
        ],
      ),
    );
  }
}
