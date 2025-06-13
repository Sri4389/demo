import 'package:flutter/material.dart';

class LoginSignupScreen extends StatefulWidget {
  @override
  _LoginSignupScreenState createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  bool isLogin = true;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void toggleFormType() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  void handleSubmit() {
    if (_formKey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;
      if (email == 'admin' && password == 'admin123') {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Show error message for invalid credentials
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Text(
                  'Screenova',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = LinearGradient(
                        colors: [Colors.green, Colors.blue],
                      ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                isLogin ? 'Welcome Back!' : 'Create Your Account',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email or Phone'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter email or phone' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) =>
                    value!.length < 6 ? 'Minimum 6 characters required' : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () =>{
                  if(emailController.text == 'admin' && passwordController.text == 'admin123') {
                    Navigator.pushReplacementNamed(context, '/home')
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Invalid email or password')),
                    )
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
                child: Text(
                  isLogin ? 'Login' : 'Sign Up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              if (isLogin)
                TextButton(
                  onPressed: () {
                    // TODO: forgot password navigation
                  },
                  child: Text('Forgot Password?'),
                ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin
                        ? "Don't have an account?"
                        : "Already have an account?",
                  ),
                  TextButton(
                    onPressed: toggleFormType,
                    child: Text(isLogin ? 'Sign Up' : 'Login'),
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
