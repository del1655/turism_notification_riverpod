import 'package:flutter/material.dart';
import 'features/home/pages/home_page.dart';

class TurismoApp extends StatelessWidget {
  const TurismoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.light();
    return MaterialApp(
      title: 'Turismo + Notificaciones',
      theme: base.copyWith(
        colorScheme: base.colorScheme.copyWith(
          primary: Colors.purpleAccent,
          secondary: Colors.orangeAccent,
        ),
        scaffoldBackgroundColor: const Color(0xFFFDF6FB), // fondo suave
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purpleAccent,
          elevation: 5,
          shadowColor: Colors.purpleAccent,
          titleTextStyle: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(  // <- cambio aquí
          color: Colors.white.withOpacity(0.25), // translúcido, efecto vidrio
          elevation: 8,
          shadowColor: Colors.purpleAccent.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purpleAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
