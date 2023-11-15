// signup_screen.dart
import 'package:flutter/material.dart';
import 'package:login_and_table/user.dart';

class SignUpScreen extends StatefulWidget {
  final UserMixin userMixin;

  const SignUpScreen({Key? key, required this.userMixin}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: !showPassword,
                controller: passwordController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ElevatedButton(
                child: const Text('Sign Up'),
                onPressed: () {
                  String enteredEmail = emailController.text;
                  String enteredPassword = passwordController.text;

                  // Check if the email has the required domain
                  if (enteredEmail.endsWith("@gmail.com")) {
                    // Perform user registration
                    widget.userMixin.addUser(enteredEmail, enteredPassword);

                    // Navigate back to the previous screen
                    Navigator.pop(context);

                    // Show a success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Registration successful!')),
                    );
                  } else {
                    // Show an error message if the email domain is not valid
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please use a valid Gmail address')),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
