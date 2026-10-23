import 'package:material_ui/material_ui.dart';
import 'package:task2/pavlova/pavlova.dart';
// import 'package:task2/pavlova/recipe_functions.dart';
// import 'stack.dart';
// import 'image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
         debugShowCheckedModeBanner: false,
         home: PavlovaPage(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: const Text('Flutter Activity'),
      //     backgroundColor: Colors.blue,
      //   ),
      //   body: const SingleChildScrollView(
      //     child: Column(
      //       children: [
      //         StackPage(),
      //         SizedBox(height: 20),
      //         ImagePage(),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}