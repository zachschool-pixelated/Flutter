
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'register_page.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService auth = AuthService();

  final TextEditingController emailCtrl =
      TextEditingController();

  final TextEditingController passwordCtrl =
      TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login | GIVERA")),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // EMAIL LOGIN
              TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 12),

              TextField(
                controller: passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 12),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () async {
                    final email = emailCtrl.text.trim();
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter your email first.'),
                        ),
                      );
                      return;
                    }

                    try {
                      await auth.sendPasswordResetEmail(email);
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'If an account exists for that email, a reset link will be sent.',
                          ),
                        ),
                      );
                    } on FirebaseAuthException {
                      if (!context.mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Could not send the reset email. Check the address and try again.',
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Forgot password?'),
                ),
              ),

              ElevatedButton(
                child: loading
                    ? CircularProgressIndicator(
                        color: Colors.white)
                    : Text("Login with Email"),

                onPressed: () async {
                  setState(() => loading = true);

                  final user = await auth.signInWithEmail(
                    emailCtrl.text,
                    passwordCtrl.text,
                  );

                  if (!context.mounted) return;
                  setState(() => loading = false);

                  if (user != null) {
                    if (!user.emailVerified) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Please verify your email before logging in.",
                          ),
                        ),
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomePage(),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Invalid email or password",
                        ),
                      ),
                    );
                  }
                },
              ),

              SizedBox(height: 24),

              Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text("OR"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),

              SizedBox(height: 24),

              // GOOGLE SIGN-IN
              ElevatedButton.icon(
                icon: Icon(Icons.login),
                label: Text("Sign in with Google"),

                onPressed: () async {
                  setState(() => loading = true);

                  final user = await auth.signInWithGoogle();

                  if (!context.mounted) return;
                  setState(() => loading = false);

                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage(),
                      ),
                    );
                  }
                },
              ),

              SizedBox(height: 12),

              TextButton(
                child: Text(
                  "Don't have an account? Register",
                ),

                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }
}
