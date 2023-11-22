import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flight_savvy/model/flight_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();


  //Singup Control
  Future<UserModel> signUp(UserModel user) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Save the username to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': user.username,
      });

      return UserModel(email: user.email, password: user.password, username: user.username);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }


  //Login Control
  Future<UserModel> login(UserModel user) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Retrieve the username from Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
      String username = userData['username'] as String? ?? '';

      return UserModel(email: user.email, password: user.password, username: username);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }


  // Forgot password Control
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      // Handle errors here
      throw Exception(e.message);
    }
  }

  //Google Sign in Control
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return UserModel(
        email: userCredential.user!.email!,
        password: '', // Password is not needed for Google Sign-In
        username: userCredential.user!.displayName ?? '',
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
