import 'package:flutter/material.dart';
import 'main_axis_end.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task 3 - MainAxisAlignment.end',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MainAxisAlignmentEndScreen(),
    );
  }
}
