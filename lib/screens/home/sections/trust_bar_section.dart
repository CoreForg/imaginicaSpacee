import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../providers/home_navigation_provider.dart';

class TrustBarSection extends StatelessWidget {
  const TrustBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final navProvider = Provider.of<HomeNavigationProvider>(context, listen: false);

    final skills = [
      ('Flutter', Icons.phone_android_rounded),
      ('Full Stack', Icons.layers_rounded),
      ('Firebase', Icons.local_fire_department_rounded),
      ('Mobile Apps', Icons.smartphone_rounded),
      ('UI/UX', Icons.design_services_rounded),
      ('SaaS', Icons.cloud_rounded),
      ('Startup MVP', Icons.rocket_launch_rounded),
      ('AI Products', Icons.auto_awesome_rounded),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 48,
      ),
      decoration: const BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(color: AppColors.border),
        ),
        color: AppColors.surface,
      ),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: skills.map((skill) {
              return _SkillChip(
                title: skill.$1,
                icon: skill.$2,
                onTap: () => navProvider.filterProjects(skill.$1),
              );
            }).toList(),
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.surfaceHighlight.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.verified_rounded, color: AppColors.accent, size: 18),
                const SizedBox(width: 12),
                Flexible(
                  child: Text(
                    'Startup-focused development · Scalable apps & SaaS · Affordable premium solutions · Cross-platform systems',
                    style: GoogleFonts.inter(
                      color: AppColors.secondaryText,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
        ],
      ),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _SkillChip({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        if (mounted) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (mounted) setState(() => _isHovered = false);
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceHighlight : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _isHovered
                  ? AppColors.accent.withValues(alpha: 0.5)
                  : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _isHovered ? AppColors.accent : AppColors.secondaryText,
                size: 14,
              ),
              const SizedBox(width: 8),
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  color: _isHovered ? AppColors.primaryText : AppColors.secondaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
