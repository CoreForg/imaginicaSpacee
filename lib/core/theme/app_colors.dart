import 'package:flutter/material.dart';

class AppColors {
  // Core backgrounds — unchanged dark theme
  static const Color background = Color(0xFF09090B);
  static const Color surface = Color(0xFF18181B);
  static const Color surfaceHighlight = Color(0xFF27272A);
  static const Color surfaceCard = Color(0xFF1C1C1F);

  // Text
  static const Color primaryText = Color(0xFFFAFAFA);
  static const Color secondaryText = Color(0xFFA1A1AA);
  static const Color mutedText = Color(0xFF52525B);

  // Accents
  static const Color accent = Color(0xFF3B82F6);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentGreen = Color(0xFF22C55E);
  static const Color accentAmber = Color(0xFFF59E0B);

  // Borders
  static const Color border = Color(0xFF27272A);
  static const Color borderHighlight = Color(0xFF3F3F46);

  // Gradient helpers
  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static RadialGradient heroGlow = RadialGradient(
    colors: [
      const Color(0xFF3B82F6).withValues(alpha: 0.12),
      Colors.transparent,
    ],
    radius: 0.7,
  );
}
