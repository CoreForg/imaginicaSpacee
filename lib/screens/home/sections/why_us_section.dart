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

    final reasons = [
      (
        Icons.bolt_rounded,
        'Fast Delivery',
        'We ship MVPs in weeks, not months. Agile by default.',
      ),
      (
        Icons.design_services_rounded,
        'Premium UI/UX',
        'Every pixel matters. We build interfaces people love.',
      ),
      (
        Icons.architecture_rounded,
        'Scalable Architecture',
        'Systems built to handle your next 10x growth.',
      ),
      (
        Icons.rocket_launch_rounded,
        'Startup-First Mindset',
        'We think like founders. Speed, iteration, and impact.',
      ),
      (
        Icons.devices_rounded,
        'Cross-Platform',
        'One codebase — iOS, Android, Web, Desktop.',
      ),
      (
        Icons.support_agent_rounded,
        'Ongoing Support',
        'We don\'t disappear at launch. We grow with you.',
      ),
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
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              'We combine elite engineering with a startup mindset to help founders and businesses build products that compete at the highest level.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: AppColors.secondaryText,
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 56),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (Responsive.isTablet(context) ? 2 : 3),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 3.5 : 1.8,
            ),
            itemCount: reasons.length,
            itemBuilder: (context, index) {
              return _WhyUsCard(
                icon: reasons[index].$1,
                title: reasons[index].$2,
                description: reasons[index].$3,
                delay: index * 80,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _WhyUsCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final int delay;

  const _WhyUsCard({
    required this.icon,
    required this.title,
    required this.description,
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
      onEnter: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isHovered = true);
      }),
      onExit: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isHovered = false);
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _isHovered ? AppColors.surfaceHighlight : AppColors.background,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppColors.accent.withValues(alpha: 0.3)
                : AppColors.border,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.06),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppColors.accent.withValues(alpha: 0.15)
                    : AppColors.surfaceHighlight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                widget.icon,
                color: _isHovered ? AppColors.accent : AppColors.secondaryText,
                size: 22,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      color: AppColors.primaryText,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.description,
                    style: GoogleFonts.inter(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: widget.delay.ms).slideY(begin: 0.1),
    );
  }
}
