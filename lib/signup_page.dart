import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _obscurePassword = true;
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),
                Text(
                  'Create your new\naccount',
                  style: TextStyle(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  'Create an account to start looking for the food\nyou like',
                  style: TextStyle(
                      fontSize: width * 0.037,
                      color: Colors.grey,
                      fontFamily: 'Inter'),
                ),
                SizedBox(height: height * 0.03),
                Text('Email Address',
                    style: TextStyle(
                        fontSize: width * 0.037, fontFamily: 'Inter')),
                SizedBox(height: height * 0.01),
                TextField(
                  decoration: InputDecoration(
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
                Text('User Name',
                    style: TextStyle(
                        fontSize: width * 0.037, fontFamily: 'Inter')),
                SizedBox(height: height * 0.01),
                TextField(
                  decoration: InputDecoration(
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
                        fontSize: width * 0.037, fontFamily: 'Inter')),
                SizedBox(height: height * 0.01),
                TextField(
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
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
                SizedBox(height: height * 0.015),
                Row(
                  children: [
                    Checkbox(
                      value: _agreedToTerms,
                      onChanged: (value) =>
                          setState(() => _agreedToTerms = value!),
                      activeColor: const Color(0xFF520350),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: width * 0.037,
                              fontFamily: 'Inter'),
                          children: const [
                            TextSpan(text: 'I Agree with '),
                            TextSpan(
                              text: 'Terms of Service',
                              style: TextStyle(color: Color(0xFF520350)),
                            ),
                            TextSpan(text: ' and '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(color: Color(0xFF520350)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                SizedBox(
                  width: double.infinity,
                  height: height * 0.07,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF520350),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                    child: Text(
                      'Register',
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
                            fontFamily: 'Inter',
                            fontSize: width * 0.037))),
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
                              fontFamily: 'Inter', fontSize: width * 0.037)),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: const Color(0xFF520350),
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Inter',
                              fontSize: width * 0.037),
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
