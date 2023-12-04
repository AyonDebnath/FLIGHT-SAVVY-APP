import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flight_savvy/firebase_options.dart';
import 'package:flight_savvy/view/HomePage.dart';
import 'package:flight_savvy/view/passengerView.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flight_savvy/view/login_view.dart';
import 'package:provider/provider.dart';
import 'locator.dart';
import 'view/profile_view.dart';

void main() async {
  setUpLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Check if user is logged in
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) {
      runApp(MyApp(home: LoginView())); // Not logged in, show login view
    } else {
      String username = await fetchUsername(user.uid);
      runApp(MyApp(home: HomePage(username: username))); // Logged in, show home page
    }
  });
}

Future<String> fetchUsername(String userId) async {
  var userDocument = await FirebaseFirestore.instance.collection('users').doc(userId).get();
  return userDocument.data()?['username'] ?? 'Guest';
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);
  static String selectedCurrency = 'CAD';
  final Widget home;
  const MyApp({Key? key, required this.home}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<ItemViewModel>(
                  create: (context) => locator<ItemViewModel>())],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light(),
                themeMode: currentMode,
                darkTheme: ThemeData.dark(),
                home: home,
          ));
        });
  }
}
