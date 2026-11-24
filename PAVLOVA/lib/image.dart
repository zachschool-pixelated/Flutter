import 'package:material_ui/material_ui.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Images',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 10),

        Image.asset(
          'assets/male.jpg',
          height: 150,
          width: 150,
          fit: BoxFit.cover,
        ),

        const SizedBox(height: 10),

        Image.asset(
          'assets/female.jpg',
          height: 150,
          width: 150,
          fit: BoxFit.cover,
        ),

        const SizedBox(height: 10),

        Image.asset(
          'assets/male.jpg',
          height: 150,
          width: 150,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
