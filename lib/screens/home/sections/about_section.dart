import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final highlights = [
      (Icons.rocket_launch_rounded, 'Startup-Focused', 'Built for founders who move fast'),
      (Icons.architecture_rounded, 'Scalable Architecture', 'Systems designed to grow with you'),
      (Icons.devices_rounded, 'Cross-Platform', 'One codebase, every platform'),
      (Icons.verified_rounded, 'Enterprise-Grade', 'Production quality from day one'),
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Us',
            style: GoogleFonts.inter(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn().slideX(begin: -0.1),
          const SizedBox(height: 16),
          Text(
            'Imaginica Space',
            style: GoogleFonts.inter(
              color: AppColors.primaryText,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
          const SizedBox(height: 40),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'A modern digital product studio focused on building scalable apps, SaaS platforms, and startup MVPs that make an impact.',
                      style: GoogleFonts.inter(
                        color: AppColors.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'At Imaginica Space, we believe great software is the foundation of every successful business. We combine deep Flutter and full-stack engineering expertise with a startup mindset — shipping fast, iterating smart, and building systems that scale.',
                      style: GoogleFonts.inter(
                        color: AppColors.secondaryText,
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Our team has hands-on experience contributing to enterprise-grade Flutter projects including the IRCTC Rail Connect platform (CRIS), and actively builds scalable digital solutions for businesses and startups across industries.',
                      style: GoogleFonts.inter(
                        color: AppColors.secondaryText,
                        fontSize: 16,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: ['Flutter', 'Dart', 'Full Stack', 'Firebase', 'SaaS', 'MVP Development'].map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceHighlight,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            tag,
                            style: GoogleFonts.inter(
                              color: AppColors.primaryText,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ).animate().fadeIn(delay: 200.ms),
              ),
              if (!isMobile) ...[
                const SizedBox(width: 80),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: highlights.map((h) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceHighlight,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(h.$1, color: AppColors.accent, size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    h.$2,
                                    style: GoogleFonts.inter(
                                      color: AppColors.primaryText,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    h.$3,
                                    style: GoogleFonts.inter(
                                      color: AppColors.secondaryText,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
