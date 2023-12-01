import 'package:flight_savvy/firebase_options.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.light);

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          // Remove the debug banner
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<ItemViewModel>(
                  create: (context) => locator<ItemViewModel>())],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData.light(),
                themeMode: currentMode,
                darkTheme: ThemeData.dark(),
                home: LoginView(),
          ));
        });
  }
}
