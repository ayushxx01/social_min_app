import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:socialmin/core/themes/dark_mode.dart';
import 'package:socialmin/core/themes/light_mode.dart';
import 'package:socialmin/firebase_options.dart';
import 'package:socialmin/presentation/Home/pages/home_page.dart';
import 'package:socialmin/presentation/auth/pages/auth.dart';
import 'package:socialmin/presentation/login/pages/login_page.dart';
import 'package:socialmin/presentation/profile/pages/profile_page.dart';
import 'package:socialmin/presentation/users/pages/users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Auth(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_page': (context) => LoginPage(),
        '/profile_page': (context) => ProfilePage(),
        '/auth': (context) => const Auth(),
        '/home_page': (context) => HomePage(),
        '/users_page': (context) => const UsersPage(),
      },
    );
  }
}
