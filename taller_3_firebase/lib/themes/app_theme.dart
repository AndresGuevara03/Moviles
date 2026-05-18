import 'package:flutter/material.dart';

/// Tema oscuro moderno con acentos cyan/indigo para Glassmorphism.
class AppTheme {
  static const Color _bgTop = Color(0xFF0F172A); // Slate 900
  static const Color _bgBottom = Color(0xFF312E81); // Indigo 900

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _bgTop,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF22D3EE), // Cyan 400
        secondary: Color(0xFF818CF8), // Indigo 400
        surface: Color(0xFF1E293B), // Slate 800
        onSurface: Colors.white,
        error: Color(0xFFF87171),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF22D3EE), width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFF87171)),
        ),
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF22D3EE),
        foregroundColor: Color(0xFF0F172A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF22D3EE),
          foregroundColor: const Color(0xFF0F172A),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static BoxDecoration get scaffoldGradient {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_bgTop, _bgBottom],
      ),
    );
  }
}
