import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    // (label, icon, accentColor)
    final techs = [
      ('Flutter', Icons.phone_android_rounded, AppColors.accent),
      ('Dart', Icons.code_rounded, AppColors.accent),
      ('Firebase', Icons.local_fire_department_rounded, const Color(0xFFF59E0B)),
      ('Java', Icons.coffee_rounded, const Color(0xFFEF4444)),
      ('Spring Boot', Icons.spa_rounded, const Color(0xFF22C55E)),
      ('PostgreSQL', Icons.storage_rounded, const Color(0xFF3B82F6)),
      ('Node.js', Icons.hub_rounded, const Color(0xFF22C55E)),
      ('REST APIs', Icons.api_rounded, AppColors.accentPurple),
      ('GitHub', Icons.folder_special_rounded, AppColors.secondaryText),
      ('HTML', Icons.html_rounded, const Color(0xFFEF4444)),
      ('CSS', Icons.css_rounded, const Color(0xFF3B82F6)),
      ('JavaScript', Icons.javascript_rounded, const Color(0xFFF59E0B)),
      ('React', Icons.cyclone_rounded, const Color(0xFF06B6D4)),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Technologies',
            style: GoogleFonts.inter(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn().slideY(begin: 0.1),
          const SizedBox(height: 16),
          Text(
            'Our Tech Stack',
            style: GoogleFonts.inter(
              color: AppColors.primaryText,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Text(
              'Modern tools and frameworks we use to deliver premium digital products.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppColors.secondaryText,
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 52),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: techs.asMap().entries.map((entry) {
              return _TechBadge(
                label: entry.value.$1,
                icon: entry.value.$2,
                accentColor: entry.value.$3,
                delay: entry.key * 45,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _TechBadge extends StatefulWidget {
  final String label;
  final IconData icon;
  final Color accentColor;
  final int delay;

  const _TechBadge({
    required this.label,
    required this.icon,
    required this.accentColor,
    required this.delay,
  });

  @override
  State<_TechBadge> createState() => _TechBadgeState();
}

class _TechBadgeState extends State<_TechBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    // Key stability principle:
    // - Border width stays FIXED at 1.5 always (no layout shift from border change)
    // - FontWeight stays FIXED at w500 always (no text-width shift)
    // - Padding stays FIXED (no layout shift)
    // - Only COLOR, boxShadow, and icon color animate
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) {
        if (mounted) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (mounted) setState(() => _isHovered = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        // Fixed padding — never changes
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          // Only background color animates
          color: _isHovered
              ? widget.accentColor.withValues(alpha: 0.09)
              : AppColors.surfaceHighlight.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(14),
          // Border width FIXED — only color changes
          border: Border.all(
            color: _isHovered
                ? widget.accentColor.withValues(alpha: 0.45)
                : AppColors.border,
            width: 1.5, // always 1.5 — no layout shift
          ),
          // Glow shadow on hover
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.accentColor.withValues(alpha: 0.15),
                    blurRadius: 14,
                    spreadRadius: 0,
                    offset: const Offset(0, 3),
                  ),
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Only icon COLOR changes — size fixed
            AnimatedTheme(
              duration: const Duration(milliseconds: 200),
              data: ThemeData(), // ignored, used for timing parity
              child: Icon(
                widget.icon,
                size: 16, // fixed
                color: _isHovered
                    ? widget.accentColor
                    : AppColors.secondaryText.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: GoogleFonts.inter(
                // Only color changes — weight FIXED to prevent text width shift
                color: _isHovered
                    ? AppColors.primaryText
                    : AppColors.secondaryText,
                fontSize: 14,
                fontWeight: FontWeight.w500, // fixed — no width jump
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: widget.delay.ms, duration: 350.ms)
        .slideY(begin: 0.06, end: 0, duration: 350.ms, curve: Curves.easeOut);
    // NOTE: No .scale() here — scale on entry conflicted with hover stability
  }
}
