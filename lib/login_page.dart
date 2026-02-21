import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one capital letter';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),
                Text(
                  'Login to your\naccount.',
                  style: TextStyle(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  'Please sign in to your account',
                  style: TextStyle(
                      fontSize: width * 0.037,
                      color: Colors.grey,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: height * 0.04),
                Text('Email Address',
                    style: TextStyle(
                        fontSize: width * 0.037,
                        fontFamily: 'Inter')),
                SizedBox(height: height * 0.01),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text('Password',
                    style: TextStyle(
                        fontSize: width * 0.037,
                        fontFamily: 'Inter')),
                SizedBox(height: height * 0.01),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: _validatePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Colors.grey[50],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          color: const Color(0xFF520350),
                          fontSize: width * 0.037,
                          fontFamily: 'Inter'),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.07,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      final userName = email.split('@')[0];
                      if (email.isNotEmpty) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLoggedIn', true);
                        await prefs.setString('userName', userName);
                        await prefs.setString('userEmail', email);
                        await prefs.setString('userPassword', password);
                        
                        if (!context.mounted) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WelcomePage(userName: userName),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF520350),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.042,
                          fontFamily: 'Inter'),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Center(
                    child: Text('Or sign in with',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: width * 0.037,
                            fontFamily: 'Inter'))),
                SizedBox(height: height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _socialButton(Icons.g_mobiledata, Colors.red),
                    SizedBox(width: width * 0.04),
                    _socialButton(Icons.facebook, Colors.blue),
                    SizedBox(width: width * 0.04),
                    _socialButton(Icons.apple, Colors.black),
                  ],
                ),
                SizedBox(height: height * 0.04),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account? ',
                          style: TextStyle(
                              fontSize: width * 0.037,
                              fontFamily: 'Inter')),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignupPage())),
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: const Color(0xFF520350),
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.037,
                              fontFamily: 'Inter'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
              ],
            ),
          ),
          ),
        ),
      ),
    );
  }

  Widget _socialButton(IconData icon, Color color) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Icon(icon, color: color),
    );
  }
}
