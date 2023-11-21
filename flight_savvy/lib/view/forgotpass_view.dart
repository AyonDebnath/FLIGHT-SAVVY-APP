import 'package:flutter/material.dart';
import 'package:flight_savvy/controller/flight_controller.dart';

class ForgotPassView extends StatelessWidget {
  final _emailController = TextEditingController();
  final AuthController _authController = AuthController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Forgot Password', style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset('assets/images/logo.png', width: 120),
                SizedBox(height: 20),
                Text(
                  'Reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    fillColor: Colors.teal[50],
                    filled: true,
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.teal,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    final email = _emailController.text;
                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please enter your email'))
                      );
                      return;
                    }
                    try {
                      await _authController.forgotPassword(email);
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Password reset email sent'))
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${e.toString()}'))
                      );
                    }
                  },
                  child: Text('Send Password Reset Link'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
