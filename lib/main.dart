import 'package:flutter/material.dart';

import 'pages/profile_card_page.dart';

void main() {
  runApp(const ProfileCardApp());
}

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kartu Profil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Manrope',
        scaffoldBackgroundColor: const Color(0xFFE8EBE4),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF17352C),
          surface: const Color(0xFFE8EBE4),
        ),
      ),
      home: const ProfileCardPage(),
    );
  }
}
