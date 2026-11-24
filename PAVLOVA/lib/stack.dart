import 'package:material_ui/material_ui.dart';

class StackPage extends StatelessWidget {
  const StackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Stack with Containers',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),
        Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Stack(
              children: [
                Container(height: 100, width: 100, color: Colors.red),
                Container(height: 90, width: 90, color: Colors.blue),
                Container(height: 80, width: 80, color: Colors.green),
                Container(height: 70, width: 70, color: Colors.yellow),
                Container(height: 60, width: 60, color: Colors.black),
                Container(height: 50, width: 50, color: Colors.purple),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
