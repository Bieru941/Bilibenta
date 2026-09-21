import 'package:flutter/material.dart';

class AppTheme {
  // BiliBenta Brand Colors
  static const Color primaryOrange = Color(0xFFFF7A00);
  static const Color deepBlue = Color(0xFF1A56DB);
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color primaryText = Color(0xFF111827);
  static const Color secondaryText = Color(0xFF6B7280);
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color successGreen = Color(0xFF16A34A);
  static const Color warningAmber = Color(0xFFF59E0B);
  static const Color errorRed = Color(0xFFDC2626);

  // Dark Mode Colors
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkSecondaryText = Color(0xFFCBD5E1);
  static const Color darkOrange = Color(0xFFFF8A1F);
  static const Color darkBlue = Color(0xFF4F7FF7);
  static const Color darkBorder = Color(0xFF334155);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryOrange,
      scaffoldBackgroundColor: lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: primaryText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
        iconTheme: const IconThemeData(color: primaryText),
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryText,
          fontFamily: 'Inter',
        ),
        displayMedium: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryText,
          fontFamily: 'Inter',
        ),
        headlineSmall: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: primaryText,
          fontFamily: 'Inter',
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: primaryText,
          fontFamily: 'Inter',
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: secondaryText,
          fontFamily: 'Inter',
        ),
        labelSmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: secondaryText,
          fontFamily: 'Inter',
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryOrange,
          side: const BorderSide(color: primaryOrange),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryOrange,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryOrange, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorRed),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        hintStyle: const TextStyle(color: secondaryText),
      ),
      cardTheme: CardTheme(
        color: white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: white,
        selectedItemColor: primaryOrange,
        unselectedItemColor: secondaryText,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: darkOrange,
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
        iconTheme: const IconThemeData(color: white),
      ),
      textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: white,
          fontFamily: 'Inter',
        ),
        displayMedium: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: white,
          fontFamily: 'Inter',
        ),
        headlineSmall: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: white,
          fontFamily: 'Inter',
        ),
        bodyLarge: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: white,
          fontFamily: 'Inter',
        ),
        bodyMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: darkSecondaryText,
          fontFamily: 'Inter',
        ),
        labelSmall: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: darkSecondaryText,
          fontFamily: 'Inter',
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkOrange,
          foregroundColor: white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
      cardTheme: CardTheme(
        color: darkSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkSurface,
        selectedItemColor: darkOrange,
        unselectedItemColor: darkSecondaryText,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}