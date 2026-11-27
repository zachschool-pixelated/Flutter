import 'package:material_ui/material_ui.dart';

import '../auth/login.dart';
import '../model/userdata.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Userdata().loadComments(); // restore saved comments
  } catch (e) {
    debugPrint('Could not load saved comments: $e'); // app still starts
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginForm(),
    );
  }
}
