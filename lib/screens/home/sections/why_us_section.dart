import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class WhyUsSection extends StatelessWidget {
  const WhyUsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    final reasons = [
      (
        Icons.bolt_rounded,
        'Fast Delivery',
        'MVPs and full products shipped in weeks. We move at startup speed without compromising quality.',
        AppColors.accentAmber,
      ),
      (
        Icons.design_services_rounded,
        'Premium UI/UX',
        'Every pixel is intentional. We craft interfaces people love using — clean, modern, and conversion-focused.',
        AppColors.accentPurple,
      ),
      (
        Icons.architecture_rounded,
        'Scalable Systems',
        'Built with architecture that handles your next 10x. Clean code, solid patterns, no tech debt shortcuts.',
        AppColors.accent,
      ),
      (
        Icons.price_check_rounded,
        'Startup-Friendly Pricing',
        'Enterprise-grade quality without the enterprise price tag. Premium results at pricing that makes sense for your stage.',
        AppColors.accentGreen,
      ),
      (
        Icons.devices_rounded,
        'Cross-Platform',
        'One codebase. iOS, Android, Web, and Desktop — all from a single Flutter project with native performance.',
        AppColors.accent,
      ),
      (
        Icons.support_agent_rounded,
        'Ongoing Support',
        'We don\'t vanish after launch. We stay, iterate, and grow alongside your product and business.',
        AppColors.accentGreen,
      ),
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

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
            'Why Imaginica Space',
            style: GoogleFonts.inter(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 16),
          Text(
            'Built Different',
            style: GoogleFonts.inter(
              color: AppColors.primaryText,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Premium digital experiences and modern software solutions at startup-friendly pricing. High-quality apps and websites — built for startups and businesses without enterprise-level costs.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppColors.secondaryText,
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 56),

          // Cards in wrap layout to avoid fixed-height grid issues
          _ResponsiveCardGrid(
            reasons: reasons,
            crossAxisCount: crossAxisCount,
          ),

          const SizedBox(height: 56),

          // Trust conversion badges
          _TrustBadgesRow(isMobile: isMobile),
        ],
      ),
    );
  }
}

class _ResponsiveCardGrid extends StatelessWidget {
  final List<(IconData, String, String, Color)> reasons;
  final int crossAxisCount;

  const _ResponsiveCardGrid({
    required this.reasons,
    required this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <List<(IconData, String, String, Color)>>[];
    for (var i = 0; i < reasons.length; i += crossAxisCount) {
      final end = (i + crossAxisCount).clamp(0, reasons.length);
      rows.add(reasons.sublist(i, end));
    }

    return Column(
      children: rows.asMap().entries.map((rowEntry) {
        final rowIndex = rowEntry.key;
        final rowItems = rowEntry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowItems.asMap().entries.map((itemEntry) {
              final colIndex = itemEntry.key;
              final item = itemEntry.value;
              final globalIndex = rowIndex * crossAxisCount + colIndex;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: colIndex > 0 ? 8 : 0,
                    right: colIndex < rowItems.length - 1 ? 8 : 0,
                  ),
                  child: _WhyUsCard(
                    icon: item.$1,
                    title: item.$2,
                    description: item.$3,
                    accentColor: item.$4,
                    delay: globalIndex * 80,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class _WhyUsCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color accentColor;
  final int delay;

  const _WhyUsCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.accentColor,
    required this.delay,
  });

  @override
  State<_WhyUsCard> createState() => _WhyUsCardState();
}

class _WhyUsCardState extends State<_WhyUsCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.basic,
      onEnter: (_) {
        if (mounted) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (mounted) setState(() => _isHovered = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isHovered
              ? widget.accentColor.withValues(alpha: 0.05)
              : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? widget.accentColor.withValues(alpha: 0.35)
                : AppColors.border,
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: widget.accentColor.withValues(alpha: 0.08),
                    blurRadius: 24,
                    spreadRadius: 1,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isHovered
                    ? widget.accentColor.withValues(alpha: 0.15)
                    : AppColors.surfaceHighlight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.icon,
                color: _isHovered ? widget.accentColor : AppColors.secondaryText,
                size: 22,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: GoogleFonts.inter(
                color: AppColors.primaryText,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.description,
              style: GoogleFonts.inter(
                color: AppColors.secondaryText,
                fontSize: 13,
                height: 1.55,
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: widget.delay.ms).slideY(begin: 0.08),
    );
  }
}

class _TrustBadgesRow extends StatelessWidget {
  final bool isMobile;
  const _TrustBadgesRow({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final badges = [
      (Icons.speed_rounded, 'Fast Delivery'),
      (Icons.price_check_rounded, 'Affordable'),
      (Icons.brush_rounded, 'Clean UI/UX'),
      (Icons.devices_other_rounded, 'Cross-Platform'),
      (Icons.trending_up_rounded, 'Scalable'),
      (Icons.verified_rounded, 'Reliable'),
    ];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.accent.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
          ),
          child: Text(
            'What you get with every project',
            style: GoogleFonts.inter(
              color: AppColors.accent,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 24),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: badges.asMap().entries.map((entry) {
            final badge = entry.value;
            return _TrustBadge(
              icon: badge.$1,
              label: badge.$2,
              delay: entry.key * 60,
            );
          }).toList(),
        ).animate().fadeIn(delay: 300.ms),
      ],
    );
  }
}

class _TrustBadge extends StatefulWidget {
  final IconData icon;
  final String label;
  final int delay;

  const _TrustBadge({
    required this.icon,
    required this.label,
    required this.delay,
  });

  @override
  State<_TrustBadge> createState() => _TrustBadgeState();
}

class _TrustBadgeState extends State<_TrustBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surfaceHighlight : AppColors.background,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovered ? AppColors.borderHighlight : AppColors.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              size: 15,
              color: _isHovered ? AppColors.accent : AppColors.mutedText,
            ),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: GoogleFonts.inter(
                color: _isHovered ? AppColors.primaryText : AppColors.secondaryText,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: widget.delay.ms).scale(
          begin: const Offset(0.95, 0.95),
          duration: 300.ms,
          curve: Curves.easeOutBack,
        );
  }
}
