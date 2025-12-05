import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_school_system/ViewModel/book_place.dart';
import 'package:smart_school_system/Views/Screens/admin.dart';
import 'package:smart_school_system/Views/Screens/home_screen.dart';
import 'package:smart_school_system/Views/Screens/splash_screen.dart';
import 'package:smart_school_system/Views/Screens/role_screen.dart';
import 'package:smart_school_system/Views/Screens/sign_in_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://pdxcjmtcuirsmlgjpizf.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBkeGNqbXRjdWlyc21sZ2pwaXpmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjQ4MjY5NzgsImV4cCI6MjA4MDQwMjk3OH0.tJxxynXgQfgTJMF5_Rxl-S4WzfcVnhzbm2kjy0sy2jk",
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => BookPlace(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Splash(),
        '/role': (context) => Role(),
        '/signin': (context) => SignIn(),
        '/home': (context) => Home(),
        '/admin': (context) => Admin(),
      },
    );
  }
}
