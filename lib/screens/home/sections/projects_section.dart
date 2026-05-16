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
    final isTablet = Responsive.isTablet(context);
    final navProvider = Provider.of<HomeNavigationProvider>(context);
    final activeFilter = navProvider.activeProjectFilter;

    final filters = [
      'All',
      'Mobile Apps',
      'Full Stack',
      'Firebase',
      'Dashboards',
      'UI/UX',
      'Startup MVP',
    ];

    final filteredProjects = activeFilter == 'All'
        ? kProjects
        : kProjects.where((p) => p.categories.contains(activeFilter)).toList();

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
            'Real products built for real businesses — from idea to production.',
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

          // Projects grid / list
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: isMobile
                ? Column(
                    key: ValueKey('mobile_$activeFilter'),
                    children: filteredProjects.asMap().entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _ProjectCard(project: entry.value)
                            .animate()
                            .fadeIn(delay: (entry.key * 80).ms)
                            .slideY(begin: 0.08),
                      );
                    }).toList(),
                  )
                : isTablet
                    ? _TwoColumnGrid(
                        key: ValueKey('tablet_$activeFilter'),
                        projects: filteredProjects,
                      )
                    : _TwoColumnGrid(
                        key: ValueKey('desktop_$activeFilter'),
                        projects: filteredProjects,
                      ),
          ),
        ],
      ),
    );
  }
}

class _TwoColumnGrid extends StatelessWidget {
  final List<Project> projects;
  const _TwoColumnGrid({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    // Pair up projects into rows of 2
    final rows = <List<Project>>[];
    for (var i = 0; i < projects.length; i += 2) {
      if (i + 1 < projects.length) {
        rows.add([projects[i], projects[i + 1]]);
      } else {
        rows.add([projects[i]]);
      }
    }

    return Column(
      children: rows.asMap().entries.map((entry) {
        final rowIndex = entry.key;
        final rowProjects = entry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _ProjectCard(project: rowProjects[0])
                    .animate()
                    .fadeIn(delay: (rowIndex * 2 * 80).ms)
                    .slideY(begin: 0.08),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: rowProjects.length > 1
                    ? _ProjectCard(project: rowProjects[1])
                        .animate()
                        .fadeIn(delay: (rowIndex * 2 * 80 + 80).ms)
                        .slideY(begin: 0.08)
                    : const SizedBox(),
              ),
            ],
          ),
        );
      }).toList(),
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
            boxShadow: widget.isActive
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
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

  const _ProjectCard({required this.project});

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

  IconData _getProjectIcon(List<String> categories) {
    if (categories.contains('Full Stack') && categories.contains('Dashboards')) {
      return Icons.dashboard_rounded;
    }
    if (categories.contains('Dashboards')) return Icons.bar_chart_rounded;
    if (categories.contains('Full Stack')) return Icons.layers_rounded;
    if (categories.contains('UI/UX')) return Icons.design_services_rounded;
    if (categories.contains('Mobile Apps')) return Icons.phone_android_rounded;
    return Icons.code_rounded;
  }

  Color _getAccentColor(String id) {
    switch (id) {
      case 'supplix':
        return AppColors.accent;
      case 'grocery-app':
        return AppColors.accentGreen;
      case 'voucher-vault':
        return AppColors.accentAmber;
      case 'shopapp':
        return AppColors.accentPurple;
      case 'expense-tracker':
        return AppColors.accentGreen;
      case 'motogenie':
        return AppColors.accentAmber;
      case 'nexus-forge':
        return AppColors.accentPurple;
      case 'support-system':
        return AppColors.accent;
      default:
        return AppColors.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cardAccent = _getAccentColor(widget.project.id);

    return MouseRegion(
      onEnter: (_) {
        if (mounted) setState(() => _isHovered = true);
      },
      onExit: (_) {
        if (mounted) setState(() => _isHovered = false);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered
                ? cardAccent.withValues(alpha: 0.5)
                : AppColors.border,
            width: _isHovered ? 1.5 : 1,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: cardAccent.withValues(alpha: 0.12),
                    blurRadius: 40,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project preview banner
              _ProjectBanner(
                project: widget.project,
                isHovered: _isHovered,
                icon: _getProjectIcon(widget.project.categories),
                accentColor: cardAccent,
                onTap: () => _openDetail(context),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category tags
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: widget.project.categories.take(3).map((cat) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: cardAccent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: cardAccent.withValues(alpha: 0.25)),
                          ),
                          child: Text(
                            cat,
                            style: GoogleFonts.inter(
                              color: cardAccent,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 14),

                    // Title
                    Text(
                      widget.project.title,
                      style: GoogleFonts.inter(
                        color: AppColors.primaryText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Tagline
                    Text(
                      widget.project.tagline,
                      style: GoogleFonts.inter(
                        color: cardAccent,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Description
                    Text(
                      widget.project.description,
                      style: GoogleFonts.inter(
                        color: AppColors.secondaryText,
                        fontSize: 14,
                        height: 1.55,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),

                    // Tech stack chips
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: widget.project.techStack.take(4).map((tech) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceHighlight,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(
                            tech,
                            style: GoogleFonts.inter(
                              color: AppColors.secondaryText,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // View Project button
                    _ViewProjectButton(
                      accentColor: cardAccent,
                      onTap: () => _openDetail(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectBanner extends StatelessWidget {
  final Project project;
  final bool isHovered;
  final IconData icon;
  final Color accentColor;
  final VoidCallback onTap;

  const _ProjectBanner({
    required this.project,
    required this.isHovered,
    required this.icon,
    required this.accentColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOutCubic,
          height: 160,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                accentColor.withValues(alpha: isHovered ? 0.2 : 0.1),
                AppColors.surfaceHighlight,
                AppColors.surface,
              ],
            ),
          ),
          child: project.screenshots.isNotEmpty
              ? Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                      child: AnimatedScale(
                        scale: isHovered ? 1.05 : 1.0,
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeOutCubic,
                        child: Image.asset(
                          project.screenshots.first,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceHighlight),
                        ),
                      ),
                    ),
                    // Dark gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: isHovered ? 0.5 : 0.3),
                          ],
                        ),
                      ),
                    ),
                    // View badge
                    Positioned(
                      bottom: 12, right: 14,
                      child: AnimatedOpacity(
                        opacity: isHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.background.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: accentColor.withValues(alpha: 0.4)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.open_in_new, size: 11, color: accentColor),
                              const SizedBox(width: 5),
                              Text('Case Study', style: GoogleFonts.inter(color: accentColor, fontSize: 11, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      width: isHovered ? 120 : 80,
                      height: isHovered ? 120 : 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            accentColor.withValues(alpha: isHovered ? 0.18 : 0.08),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    AnimatedScale(
                      scale: isHovered ? 1.12 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutBack,
                      child: Icon(
                        icon,
                        size: 48,
                        color: accentColor.withValues(alpha: isHovered ? 0.7 : 0.4),
                      ),
                    ),
                    Positioned(
                      bottom: 12, right: 14,
                      child: AnimatedOpacity(
                        opacity: isHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 200),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.background.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: accentColor.withValues(alpha: 0.4)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.open_in_new, size: 11, color: accentColor),
                              const SizedBox(width: 5),
                              Text('Case Study', style: GoogleFonts.inter(color: accentColor, fontSize: 11, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ViewProjectButton extends StatefulWidget {
  final Color accentColor;
  final VoidCallback onTap;

  const _ViewProjectButton({
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<_ViewProjectButton> createState() => _ViewProjectButtonState();
}

class _ViewProjectButtonState extends State<_ViewProjectButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            color: _isHovered
                ? widget.accentColor.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _isHovered
                  ? widget.accentColor.withValues(alpha: 0.6)
                  : AppColors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'View Project',
                style: GoogleFonts.inter(
                  color: _isHovered ? widget.accentColor : AppColors.secondaryText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                transform: Matrix4.translationValues(
                    _isHovered ? 4 : 0, 0, 0),
                child: Icon(
                  Icons.arrow_forward_rounded,
                  size: 15,
                  color: _isHovered ? widget.accentColor : AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
