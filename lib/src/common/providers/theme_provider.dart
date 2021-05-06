import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateProvider<ThemeData>((ref) {
  return ThemeData(
      fontFamily: 'Poppins',
      primaryColor: Colors.purple,
      accentColor: Colors.purpleAccent,
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), borderSide: BorderSide()),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.purpleAccent,
          padding: EdgeInsets.all(16),
        ),
      ));
});
