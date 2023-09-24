import 'package:flutter/material.dart';
import 'package:app_imc_flutter/pages/main_page.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // faz sumir a barrinha escrito debug
      theme: ThemeData(
          primarySwatch: Colors.orange,
          textTheme: GoogleFonts.robotoTextTheme()),
      home: const MainPage(),
    );
  }
}
