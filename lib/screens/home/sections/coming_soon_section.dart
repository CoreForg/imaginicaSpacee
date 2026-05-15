import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class ComingSoonSection extends StatelessWidget {
  const ComingSoonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 64,
      ),
      color: AppColors.background,
      child: Column(
        children: [
          const Divider(color: AppColors.border),
          const SizedBox(height: 48),
          _ComingSoonContent(isMobile: isMobile),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _ComingSoonContent extends StatefulWidget {
  final bool isMobile;
  const _ComingSoonContent({required this.isMobile});

  @override
  State<_ComingSoonContent> createState() => _ComingSoonContentState();
}

class _ComingSoonContentState extends State<_ComingSoonContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Animated dot indicator
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, _) {
            return Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: _pulseAnimation.value),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: _pulseAnimation.value * 0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),

        // Label
        Text(
          'What\'s Next',
          style: GoogleFonts.inter(
            color: AppColors.accent,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ).animate().fadeIn(delay: 100.ms),
        const SizedBox(height: 12),

        // Headline
        Text(
          'More experiences coming soon.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: AppColors.primaryText,
            fontSize: widget.isMobile ? 24 : 32,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.08),
        const SizedBox(height: 12),

        // Subtitle
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Text(
            'We\'re building more projects, case studies, and digital products. Stay connected — the best is still being shipped.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: AppColors.secondaryText,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ).animate().fadeIn(delay: 300.ms),
        const SizedBox(height: 28),

        // Chips
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            _ComingSoonChip(label: 'New Projects', icon: Icons.folder_open_rounded),
            _ComingSoonChip(label: 'Case Studies', icon: Icons.article_rounded),
            _ComingSoonChip(label: 'Open Source', icon: Icons.code_rounded),
          ],
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }
}

class _ComingSoonChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const _ComingSoonChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.mutedText),
          const SizedBox(width: 7),
          Text(
            label,
            style: GoogleFonts.inter(
              color: AppColors.secondaryText,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
