import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final steps = [
      {'num': '01', 'title': 'Discovery', 'desc': 'Understanding your goals, target audience, and business requirements.'},
      {'num': '02', 'title': 'Planning', 'desc': 'Defining the architecture, tech stack, and project roadmap.'},
      {'num': '03', 'title': 'UI/UX Design', 'desc': 'Creating premium, user-centric wireframes and high-fidelity designs.'},
      {'num': '04', 'title': 'Development', 'desc': 'Building scalable and robust software using modern technologies.'},
      {'num': '05', 'title': 'Testing', 'desc': 'Rigorous QA testing to ensure a bug-free and smooth experience.'},
      {'num': '06', 'title': 'Deployment', 'desc': 'Seamlessly launching your product to production environments.'},
      {'num': '07', 'title': 'Support', 'desc': 'Ongoing maintenance and improvements post-launch.'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Workflow',
            style: GoogleFonts.inter(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn().slideX(begin: -0.1),
          const SizedBox(height: 16),
          Text(
            'Development Process',
            style: GoogleFonts.inter(
              color: AppColors.primaryText,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
          const SizedBox(height: 48),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Container(
                height: 40,
                width: 2,
                color: AppColors.border,
              ),
            ),
            itemBuilder: (context, index) {
              final step = steps[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceHighlight,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.accent.withValues(alpha: 0.5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      step['num']!,
                      style: GoogleFonts.inter(
                        color: AppColors.accent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            step['title']!,
                            style: GoogleFonts.inter(
                              color: AppColors.primaryText,
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            step['desc']!,
                            style: GoogleFonts.inter(
                              color: AppColors.secondaryText,
                              fontSize: 16,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1);
            },
          ),
        ],
      ),
    );
  }
}
