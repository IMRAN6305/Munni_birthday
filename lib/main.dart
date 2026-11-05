import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/birthday_home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MinniBirthdayApp());
}

class MinniBirthdayApp extends StatelessWidget {
  const MinniBirthdayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Birthday Pathan Munni! 🎂👑',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF13091E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF4081),
          brightness: Brightness.dark,
          primary: const Color(0xFFFF2A6D),
          secondary: const Color(0xFFFFD700),
          surface: const Color(0xFF1E1035),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        useMaterial3: true,
      ),
      home: const BirthdayHomeScreen(),
    );
  }
}
