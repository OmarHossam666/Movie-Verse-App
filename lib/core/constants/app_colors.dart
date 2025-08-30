import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primaryBackground = Color(0xFF1A1A2E);
  static const Color secondaryBackground = Color(0xFF16213E);
  static const Color surfaceBackground = Color(0xFF0F172A);
  
  // Accent Colors
  static const Color primaryAccent = Color(0xFFFF6B47);
  static const Color secondaryAccent = Color(0xFFFF8C42);
  
  // Text Colors
  static const Color primaryText = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFFB8BCC8);
  static const Color tertiaryText = Color(0xFF8B92A5);
  static const Color mutedText = Color(0xFF64748B);
  
  // UI Element Colors
  static const Color cardBackground = Color(0xFF1E293B);
  static const Color overlayBackground = Color(0x80000000);
  static const Color transparentWhite = Color(0x4DFFFFFF);
  
  // Interactive Colors
  static const Color activeTab = Color(0xFFFF6B47);
  static const Color inactiveTab = Color(0xFF64748B);
  static const Color playButton = Color(0xFFFF6B47);
  static const Color buttonBackground = Color(0x33FFFFFF);
  
  // Rating and Status Colors
  static const Color ratingYellow = Color(0xFFFFC107);
  static const Color ratingBackground = Color(0x80000000);
  
  // Border and Divider Colors
  static const Color borderLight = Color(0xFF334155);
  static const Color borderDark = Color(0xFF1E293B);
  
  // Gradient Colors
  static const List<Color> primaryGradient = [
    Color(0xFF1A1A2E),
    Color(0xFF16213E),
    Color(0xFF0F172A),
  ];
  
  static const List<Color> overlayGradient = [
    Color(0x00000000),
    Color(0x80000000),
  ];
  
  // Brand Colors
  static const Color brandRed = Color(0xFFFF6B47);
  static const Color brandWhite = Color(0xFFFFFFFF);
  
  // Search and Input Colors
  static const Color searchBackground = Color(0xFF1E293B);
  static const Color searchBorder = Color(0xFF334155);
  static const Color placeholderText = Color(0xFF64748B);
  
  // Navigation Colors
  static const Color navBackground = Color(0xFF0F172A);
  static const Color navSelected = Color(0xFFFF6B47);
  static const Color navUnselected = Color(0xFF64748B);
  
  // Movie Card Colors
  static const Color cardShadow = Color(0x40000000);
  static const Color genreTagBackground = Color(0xFF374151);
  static const Color genreTagText = Color(0xFFD1D5DB);
  
  // Utility Colors
  static const Color transparent = Colors.transparent;
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  
  // Status Colors (for future use)
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}