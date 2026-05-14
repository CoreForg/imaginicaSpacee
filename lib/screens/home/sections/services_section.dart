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
        'details': 'From concept to deployment, I build native-feeling cross-platform applications using Flutter. Features include state management, local storage, complex animations, and seamless API integrations.',
      },
      {
        'title': 'Full Stack Web Dev', 
        'icon': Icons.web, 
        'desc': 'Scalable web applications and modern portals.',
        'details': 'Building responsive, fast, and SEO-friendly web applications using modern frameworks like Next.js and Flutter Web. Includes complete frontend and backend development.',
      },
      {
        'title': 'Startup MVP Dev', 
        'icon': Icons.rocket_launch, 
        'desc': 'Fast go-to-market MVPs for your next big idea.',
        'details': 'Helping startups validate their ideas quickly by building robust Minimum Viable Products in weeks, not months. Focus is on core features and scalable architecture.',
      },
      {
        'title': 'Backend & Firebase', 
        'icon': Icons.storage, 
        'desc': 'Robust architectures, databases & API integration.',
        'details': 'Designing secure and scalable backend systems using Node.js, Spring Boot, or Firebase. Expertise in PostgreSQL, Firestore, authentication, and cloud functions.',
      },
      {
        'title': 'UI/UX Design', 
        'icon': Icons.design_services, 
        'desc': 'Premium, user-centric interfaces and experiences.',
        'details': 'Creating stunning, modern, and minimal user interfaces inspired by top tech companies. Focus on accessibility, micro-interactions, and conversion optimization.',
      },
      {
        'title': 'SaaS Products', 
        'icon': Icons.cloud, 
        'desc': 'End-to-end development of modern SaaS platforms.',
        'details': 'Developing complex SaaS dashboards with multi-tenant architectures, subscription handling (Stripe), real-time analytics, and role-based access control.',
      },
    ];

    int crossAxisCount = isMobile ? 1 : (isTablet ? 2 : 3);

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
            'What I can build for you',
            style: GoogleFonts.inter(
              color: AppColors.primaryText,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),
          const SizedBox(height: 48),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              mainAxisExtent: isMobile ? null : 280, // Allow expansion
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              return _ServiceCard(
                title: services[index]['title'] as String,
                description: services[index]['desc'] as String,
                details: services[index]['details'] as String,
                icon: services[index]['icon'] as IconData,
                delay: 100 * index,
              );
            },
          ),
        ],
      ),
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
      onEnter: (_) => WidgetsBinding.instance.addPostFrameCallback((_) { if (mounted) setState(() => _isHovered = true); }),
      onExit: (_) => WidgetsBinding.instance.addPostFrameCallback((_) { if (mounted) setState(() => _isHovered = false); }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => setState(() => _isExpanded = !_isExpanded),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.surfaceHighlight : AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? AppColors.accent.withValues(alpha: 0.5) : AppColors.border,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.2),
                      blurRadius: 30,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: Icon(widget.icon, color: AppColors.primaryText, size: 24),
              ),
              const SizedBox(height: 16),
              Text(
                widget.title,
                style: GoogleFonts.inter(
                  color: AppColors.primaryText,
                  fontSize: 20,
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
                    height: 1.5,
                  ),
                ),
                secondChild: Text(
                  widget.details,
                  style: GoogleFonts.inter(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    _isExpanded ? 'Show less' : 'Learn more',
                    style: GoogleFonts.inter(
                      color: AppColors.accent,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.accent,
                    size: 16,
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: widget.delay.ms).slideY(begin: 0.1),
    );
  }
}
