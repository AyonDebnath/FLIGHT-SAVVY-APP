import 'package:flutter/material.dart';
import '../controller/flight_controller.dart';
import '../model/flight_model.dart';
import 'login_view.dart';


class SignupView extends StatefulWidget {
  @override
  _SignupViewState createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthController _authController = AuthController();
  String _errorMessage = '';

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _errorMessage = 'Passwords do not match');
      return;
    }
    try {
      UserModel user = UserModel(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
      );
      await _authController.signUp(user);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created successfully. Please login.'))
      );
      await Future.delayed(Duration(seconds: 2));

      // Navigate to the LoginView
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginView()),
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Image.asset('assets/images/logo.png', width: 120),
              SizedBox(height: 20),
              _buildTextField(_usernameController, 'Username', false),
              SizedBox(height: 20),
              _buildTextField(_emailController, 'Email', false),
              SizedBox(height: 20),
              _buildTextField(_passwordController, 'Password', true),
              SizedBox(height: 20),
              _buildTextField(_confirmPasswordController, 'Confirm Password', true),
              SizedBox(height: 30),
              _buildButton('Create Account', _signUp),
              SizedBox(height: 20),
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        fillColor: Colors.teal[50],
        filled: true,
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.teal,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
