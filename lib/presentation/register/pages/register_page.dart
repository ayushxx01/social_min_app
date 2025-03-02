import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmin/common/helpers/helper_fn.dart';
import 'package:socialmin/common/widgets/button/my_button.dart';
import 'package:socialmin/common/widgets/textfield/my_textfield.dart';
import 'package:socialmin/presentation/login/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  Future<void> register() async {
    if (passwordController.text != confirmController.text) {
      Navigator.pop(context);
      // Show error message
      displayMessageToUser("Passwords don't match", context);
      return; // Return early to prevent further execution
    }

    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Try creating the user
    try {
      // Create the user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //create a user document and store it in firestore
      createUserDocument(userCredential);

      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pushNamed(context, '/home_page');
      } // Pop loading circle
      // User created successfully, navigate to another page or show success message
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Pop loading circle
      displayMessageToUser(e.code, context);
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Icon(Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary),

              const SizedBox(height: 25),

              // Title
              const Text(
                'S O C I L',
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 50),

              // Username
              MyTextfield(
                  hintText: 'username',
                  controller: usernameController,
                  obscureText: false),

              const SizedBox(height: 10),

              // Email
              MyTextfield(
                  hintText: 'email',
                  controller: emailController,
                  obscureText: false),

              const SizedBox(height: 10),

              // Password
              MyTextfield(
                  hintText: 'password',
                  controller: passwordController,
                  obscureText: true),

              const SizedBox(height: 10),

              // Confirm Password
              MyTextfield(
                  hintText: 'confirm password',
                  controller: confirmController,
                  obscureText: true),

              const SizedBox(height: 10),

              // Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'forgot password?',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Register Button
              MyButton(text: 'Register', onTap: register),

              const SizedBox(height: 25),

              // Already have an account
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text(
                      'Login!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
