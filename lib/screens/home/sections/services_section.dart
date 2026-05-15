import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    final services = [
      {
        'title': 'Mobile App Dev',
        'icon': Icons.phone_android,
        'desc': 'High-performance Flutter apps for iOS & Android.',
        'details':
            'From concept to deployment — native-feeling cross-platform apps with smooth animations, local storage, complex state management, and seamless API integrations.',
      },
      {
        'title': 'Full Stack Web Dev',
        'icon': Icons.web,
        'desc': 'Scalable web apps, portals, and modern websites.',
        'details':
            'Responsive, fast, and SEO-friendly web applications built with Flutter Web, React, or Next.js. Full frontend and backend development with clean architecture.',
      },
      {
        'title': 'Startup MVP Dev',
        'icon': Icons.rocket_launch,
        'desc': 'Fast go-to-market MVPs — weeks, not months.',
        'details':
            'Helping startups validate ideas quickly with robust MVPs. Focus on core features, speed to market, and scalable foundations that grow with your business.',
      },
      {
        'title': 'Backend & Firebase',
        'icon': Icons.storage,
        'desc': 'Robust backends, databases & API integrations.',
        'details':
            'Secure, scalable backend systems with Node.js, Spring Boot, or Firebase. Expert in PostgreSQL, Firestore, authentication flows, and cloud functions.',
      },
      {
        'title': 'UI/UX Design',
        'icon': Icons.design_services,
        'desc': 'Premium, user-centric interfaces and experiences.',
        'details':
            'Stunning, modern interfaces inspired by top-tier digital products. Focused on micro-interactions, accessibility, visual hierarchy, and conversion optimization.',
      },
      {
        'title': 'SaaS Products',
        'icon': Icons.cloud,
        'desc': 'End-to-end development of modern SaaS platforms.',
        'details':
            'Complex SaaS dashboards with multi-tenant architecture, subscription billing (Stripe), real-time analytics, role-based access, and clean admin panels.',
      },
    ];

    final crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: GoogleFonts.inter(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn().slideX(begin: -0.1),
          const SizedBox(height: 16),
          Text(
            'What Can I Build For You',
            style: GoogleFonts.inter(
              color: AppColors.primaryText,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
          const SizedBox(height: 8),
          Text(
            'Premium solutions at startup-friendly pricing — from MVP to production.',
            style: GoogleFonts.inter(
              color: AppColors.secondaryText,
              fontSize: 15,
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 48),

          // Responsive wrap-based grid (avoids fixed childAspectRatio issues)
          _ServiceGrid(
            services: services,
            crossAxisCount: crossAxisCount,
          ),
        ],
      ),
    );
  }
}

class _ServiceGrid extends StatelessWidget {
  final List<Map<String, dynamic>> services;
  final int crossAxisCount;

  const _ServiceGrid({required this.services, required this.crossAxisCount});

  @override
  Widget build(BuildContext context) {
    final rows = <List<Map<String, dynamic>>>[];
    for (var i = 0; i < services.length; i += crossAxisCount) {
      final end = (i + crossAxisCount).clamp(0, services.length);
      rows.add(services.sublist(i, end));
    }

    return Column(
      children: rows.asMap().entries.map((rowEntry) {
        final rowIndex = rowEntry.key;
        final rowItems = rowEntry.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowItems.asMap().entries.map((itemEntry) {
              final colIndex = itemEntry.key;
              final service = itemEntry.value;
              final globalIndex = rowIndex * crossAxisCount + colIndex;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: colIndex > 0 ? 10 : 0,
                    right: colIndex < rowItems.length - 1 ? 10 : 0,
                  ),
                  child: _ServiceCard(
                    title: service['title'] as String,
                    description: service['desc'] as String,
                    details: service['details'] as String,
                    icon: service['icon'] as IconData,
                    delay: 80 * globalIndex,
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

class _ServiceCard extends StatefulWidget {
  final String title;
  final String description;
  final String details;
  final IconData icon;
  final int delay;

  const _ServiceCard({
    required this.title,
    required this.description,
    required this.details,
    required this.icon,
    required this.delay,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;
  bool _isExpanded = false;

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
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 280),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceHighlight : AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered
                  ? AppColors.accent.withValues(alpha: 0.45)
                  : AppColors.border,
              width: _isHovered ? 1.5 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.12),
                      blurRadius: 28,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? AppColors.accent.withValues(alpha: 0.12)
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isHovered
                        ? AppColors.accent.withValues(alpha: 0.3)
                        : AppColors.border,
                  ),
                ),
                child: Icon(
                  widget.icon,
                  color: _isHovered ? AppColors.accent : AppColors.secondaryText,
                  size: 22,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  color: AppColors.primaryText,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              AnimatedCrossFade(
                firstChild: Text(
                  widget.description,
                  style: GoogleFonts.inter(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
                secondChild: Text(
                  widget.details,
                  style: GoogleFonts.inter(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                    height: 1.55,
                  ),
                ),
                crossFadeState: _isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    _isExpanded ? 'Show less' : 'Learn more',
                    style: GoogleFonts.inter(
                      color: AppColors.accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  AnimatedRotation(
                    duration: const Duration(milliseconds: 250),
                    turns: _isExpanded ? -0.5 : 0,
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.accent,
                      size: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: widget.delay.ms).slideY(begin: 0.08),
    );
  }
}
