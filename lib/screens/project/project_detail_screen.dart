import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            backgroundColor: AppColors.surface,
            pinned: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primaryText),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Case Study',
              style: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w600),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                ),
                child: Text(
                  'Imaginica Space',
                  style: GoogleFonts.inter(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 60),
                  color: AppColors.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: project.categories.map((c) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.accent.withValues(alpha: 0.2))),
                          child: Text(c, style: GoogleFonts.inter(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w600)),
                        )).toList(),
                      ).animate().fadeIn(),
                      const SizedBox(height: 20),
                      Text(project.title, style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: isMobile ? 32 : 52, fontWeight: FontWeight.bold, letterSpacing: -1)).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
                      const SizedBox(height: 12),
                      Text(project.tagline, style: GoogleFonts.inter(color: AppColors.accent, fontSize: 18, fontWeight: FontWeight.w500)).animate().fadeIn(delay: 150.ms),
                      const SizedBox(height: 16),
                      Text(project.overview, style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 16, height: 1.6)).animate().fadeIn(delay: 200.ms),
                    ],
                  ),
                ),

                // Preview mockup
                Container(
                  width: double.infinity,
                  height: isMobile ? 220 : 360,
                  margin: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 32),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.accent.withValues(alpha: 0.15), AppColors.surfaceHighlight],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome_rounded, size: 48, color: AppColors.accent.withValues(alpha: 0.4)),
                        const SizedBox(height: 12),
                        Text('Project Preview', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 14)),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.96, 0.96)),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _DetailSection(title: 'The Problem', content: project.problem, icon: Icons.help_outline_rounded),
                      const SizedBox(height: 32),
                      _DetailSection(title: 'Our Solution', content: project.solution, icon: Icons.lightbulb_outline_rounded),
                      const SizedBox(height: 32),

                      // Features
                      _SectionLabel(title: 'Key Features', icon: Icons.check_circle_outline_rounded),
                      const SizedBox(height: 16),
                      ...project.features.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              width: 6, height: 6,
                              decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(e.value, style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 15, height: 1.5))),
                          ],
                        ).animate().fadeIn(delay: (e.key * 60).ms),
                      )),
                      const SizedBox(height: 32),
                      _DetailSection(title: 'Architecture & Workflow', content: project.architecture, icon: Icons.architecture_rounded),
                      const SizedBox(height: 32),
                      _DetailSection(title: 'Results & Impact', content: project.results, icon: Icons.trending_up_rounded),
                      const SizedBox(height: 32),

                      // Tech stack
                      _SectionLabel(title: 'Technologies Used', icon: Icons.code_rounded),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10, runSpacing: 10,
                        children: project.techStack.map((t) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(color: AppColors.surfaceHighlight, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
                          child: Text(t, style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14, fontWeight: FontWeight.w500)),
                        )).toList(),
                      ).animate().fadeIn(delay: 100.ms),
                      const SizedBox(height: 48),

                      // CTA
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border)),
                        child: Column(
                          children: [
                            Text('Interested in a Similar Project?', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Text('Let\'s discuss how Imaginica Space can build your next product.', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 15), textAlign: TextAlign.center),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                              child: Text('Start Your Project', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionLabel({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent, size: 20),
        const SizedBox(width: 10),
        Text(title, style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    ).animate().fadeIn().slideX(begin: -0.05);
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  const _DetailSection({required this.title, required this.content, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(title: title, icon: icon),
        const SizedBox(height: 14),
        Text(content, style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 16, height: 1.7)),
      ],
    );
  }
}
