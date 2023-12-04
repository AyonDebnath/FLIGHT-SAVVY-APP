import 'package:firebase_auth/firebase_auth.dart';
import 'package:flight_savvy/view/HomePage.dart';
import 'package:flutter/material.dart';
import 'signup_view.dart';
import 'forgotpass_view.dart';
import 'package:flight_savvy/controller/flight_controller.dart';
import 'package:flight_savvy/model/flight_model.dart';
import 'homepage_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  String _errorMessage = '';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    UserModel user = UserModel(
      email: _emailController.text,
      password: _passwordController.text,
    );

    try {
      UserModel loggedInUser = await _authController.login(user);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage(username: loggedInUser.username)),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      setState(() {
        _errorMessage = "Please provide a valid email and/or password";
      });
    }
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> _loginWithGoogle() async {
    try {
      UserModel loggedInUser = await _authController.signInWithGoogle();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage(username: loggedInUser.username)),
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      setState(() {
        //_errorMessage = e.toString();
      });
    }
  }

  void _continueAsGuest() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => HomePage(username: "Guest")),
          (Route<dynamic> route) => false,
    );
  }

  Widget _buildGuestButton() {
    return TextButton(
      onPressed: _continueAsGuest,
      child: Text('Continue as Guest', style: TextStyle(color: Colors.teal)),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Welcome', style: TextStyle(color: Colors.teal)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  width: 170,
                  height: 150,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Fly Savvy',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 40),
                _buildTextField(_emailController, 'Email', false),
                SizedBox(height: 20),
                _buildTextField(_passwordController, 'Password', true),
                SizedBox(height: 30),
                _buildButton(context, _login, 'Login', Colors.teal, Colors.white),
                SizedBox(height: 15),
                _buildButton(context, _loginWithGoogle, 'Sign in with Google', Colors.white, Colors.teal),
                if (_errorMessage.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
                _buildFlatButton(context, SignupView(), "Don't have an account? Sign Up"),
                _buildFlatButton(context, ForgotPassView(), 'Forgot Password?'),
                _buildGuestButton(),
              ],
            ),
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
        border: OutlineInputBorder(),
        fillColor: Colors.blueGrey[50],
        filled: true,
      ),
    );
  }

  Widget _buildButton(BuildContext context, VoidCallback onPressed, String label, Color backgroundColor, Color textColor) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: textColor, backgroundColor: backgroundColor,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }


  Widget _buildFlatButton(BuildContext context, Widget view, String label) {
    return TextButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => view)),
      child: Text(label, style: TextStyle(color: Colors.blueGrey)),
    );
  }
}
