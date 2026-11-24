import 'package:flutter/material.dart';
import 'alignment/edge_insets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GIVERA'),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              edgeInsetsBox(
                'EdgeInsets.all(30)',
                const EdgeInsets.all(30),
                Colors.red,
              ),

              edgeInsetsBox(
                'EdgeInsets.symmetric(horizontal: 40, vertical: 10)',
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                Colors.yellow,
                textColor: Colors.black,
              ),

              edgeInsetsBox(
                'EdgeInsets.only(left: 30, top: 10, right: 5, bottom: 20)',
                const EdgeInsets.only(left: 30, top: 10, right: 5, bottom: 20),
                Colors.blue,
              ),

              edgeInsetsBox(
                'EdgeInsets.fromLTRB(10, 20, 30, 40)',
                const EdgeInsets.fromLTRB(10, 20, 30, 40),
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
