import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../models/project.dart';
import '../../../providers/home_navigation_provider.dart';
import '../../project/project_detail_screen.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final navProvider = Provider.of<HomeNavigationProvider>(context);
    final activeFilter = navProvider.activeProjectFilter;

    final filteredProjects = activeFilter == 'All'
        ? kProjects
        : kProjects.where((p) => p.categories.contains(activeFilter)).toList();

    final filters = [
      'All', 'Mobile Apps', 'Full Stack', 'AI SaaS', 'Dashboards',
      'Firebase', 'UI/UX', 'Startup MVP', 'Flutter Web',
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
            'Selected Work',
            style: GoogleFonts.inter(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn().slideX(begin: -0.1),
          const SizedBox(height: 16),
          Text(
            'Featured Projects',
            style: GoogleFonts.inter(
              color: AppColors.primaryText,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
          const SizedBox(height: 8),
          Text(
            'End-to-end digital products built for real businesses.',
            style: GoogleFonts.inter(
              color: AppColors.secondaryText,
              fontSize: 16,
            ),
          ).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 32),

          // Filter chips
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: filters.map((filter) {
              final isActive = activeFilter == filter;
              return _FilterChip(
                label: filter,
                isActive: isActive,
                onTap: () => navProvider.filterProjects(filter),
              );
            }).toList(),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 48),

          // Projects list
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: ListView.separated(
              key: ValueKey(activeFilter),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredProjects.length,
              separatorBuilder: (context, index) => const SizedBox(height: 32),
              itemBuilder: (context, index) {
                final project = filteredProjects[index];
                return _ProjectCard(
                  project: project,
                  isEven: index % 2 == 0,
                ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_FilterChip> createState() => _FilterChipState();
}

class _FilterChipState extends State<_FilterChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isHovered = true);
      }),
      onExit: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isHovered = false);
      }),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.accent
                : _isHovered
                    ? AppColors.surfaceHighlight
                    : AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isActive
                  ? AppColors.accent
                  : _isHovered
                      ? AppColors.accent.withValues(alpha: 0.3)
                      : AppColors.border,
            ),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              color: widget.isActive
                  ? Colors.white
                  : _isHovered
                      ? AppColors.primaryText
                      : AppColors.secondaryText,
              fontSize: 13,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Project project;
  final bool isEven;

  const _ProjectCard({required this.project, required this.isEven});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  void _openDetail(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, _) =>
            ProjectDetailScreen(project: widget.project),
        transitionsBuilder: (context, animation, _, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final preview = Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _openDetail(context),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              height: isMobile ? 220 : 380,
              transform: Matrix4.identity()
                ..scale(_isHovered ? 1.03 : 1.0, _isHovered ? 1.03 : 1.0, 1.0),
              transformAlignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.accent.withValues(alpha: 0.15),
                    AppColors.surfaceHighlight,
                  ],
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    _getProjectIcon(widget.project.categories),
                    size: 64,
                    color: AppColors.accent.withValues(alpha: 0.3),
                  ),
                  Positioned(
                    bottom: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.background.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.open_in_new, size: 12, color: AppColors.accent),
                          const SizedBox(width: 6),
                          Text(
                            'Case Study',
                            style: GoogleFonts.inter(
                              color: AppColors.accent,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    final content = Expanded(
      child: Container(
        padding: const EdgeInsets.all(36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Category tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project.categories.take(3).map((cat) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                ),
                child: Text(
                  cat,
                  style: GoogleFonts.inter(
                    color: AppColors.accent,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 16),
            Text(
              widget.project.title,
              style: GoogleFonts.inter(
                color: AppColors.primaryText,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.project.tagline,
              style: GoogleFonts.inter(
                color: AppColors.accent,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.project.description,
              style: GoogleFonts.inter(
                color: AppColors.secondaryText,
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.project.techStack.take(4).map((tech) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.surfaceHighlight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  tech,
                  style: GoogleFonts.inter(
                    color: AppColors.primaryText,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 28),
            OutlinedButton(
              onPressed: () => _openDetail(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryText,
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View Case Study',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return MouseRegion(
      onEnter: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isHovered = true);
      }),
      onExit: (_) => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _isHovered = false);
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: _isHovered
                ? AppColors.accent.withValues(alpha: 0.4)
                : AppColors.border,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.08),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: isMobile
              ? Column(children: [preview, content])
              : Row(
                  children: widget.isEven
                      ? [preview, content]
                      : [content, preview],
                ),
        ),
      ),
    );
  }

  IconData _getProjectIcon(List<String> categories) {
    if (categories.contains('AI SaaS') || categories.contains('Dashboards')) {
      return Icons.auto_awesome_rounded;
    }
    if (categories.contains('Mobile Apps')) return Icons.phone_android_rounded;
    if (categories.contains('Full Stack')) return Icons.layers_rounded;
    if (categories.contains('UI/UX')) return Icons.design_services_rounded;
    return Icons.code_rounded;
  }
}
