import 'package:flutter/material.dart';
import 'register.dart';

// Login screen
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LandingPage(
          username: username,
          password: password,
        ),
      ),
    );
  }

  void _goToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('GIVERA Activity 2'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter your username',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _login,
                style: buttonStyle.copyWith(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.blue),
                  foregroundColor:
                      WidgetStateProperty.all(Colors.white),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _goToRegister,
                style: buttonStyle.copyWith(
                  backgroundColor:
                      WidgetStateProperty.all(Colors.blue),
                  foregroundColor:
                      WidgetStateProperty.all(Colors.white),
                  side: WidgetStateProperty.all(
                    const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
                child: const Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// This screen is shown after the Login button is tapped.
class LandingPage extends StatelessWidget {
  final String username;
  final String password;

  const LandingPage({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lastname Activity 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('user: $username', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            Text('Password: $password',
                style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
