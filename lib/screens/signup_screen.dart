import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hulkify',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
              ),
              SizedBox(height: 40),
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
                icon: Icons.email,
              ),
              SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: !_isPasswordVisible,
                icon: Icons.lock,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              SizedBox(height: 16),
              CustomButton(
                text: 'Sign Up',
                onPressed: () async {
                  final user = await AuthService().signUp(
                    emailController.text,
                    passwordController.text,
                  );
                  if (user != null) {
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    print('Sign Up failed');
                  }
                },
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  'Already have an account? Login',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
