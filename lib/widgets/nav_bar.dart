import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../providers/home_navigation_provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<HomeNavigationProvider>(context);
    final isScrolled = navProvider.isScrolled;
    final isMobile = Responsive.isMobile(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: isScrolled ? 12 : 0,
          sigmaY: isScrolled ? 12 : 0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 40,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: isScrolled
                ? AppColors.background.withValues(alpha: 0.85)
                : Colors.transparent,
            border: isScrolled
                ? const Border(
                    bottom: BorderSide(color: AppColors.border, width: 1),
                  )
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo — long press opens admin
              GestureDetector(
                onTap: () => navProvider.scrollTo('hero'),
                onLongPress: () => Navigator.pushNamed(context, '/admin'),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: isMobile ? 24 : 28,
                        filterQuality: FilterQuality.high,
                      ),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Imaginica',
                              style: GoogleFonts.inter(
                                color: AppColors.primaryText,
                                fontSize: isMobile ? 18 : 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                            TextSpan(
                              text: ' Space',
                              style: GoogleFonts.inter(
                                color: AppColors.accent,
                                fontSize: isMobile ? 18 : 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Desktop nav items
              if (!isMobile)
                Row(
                  children: [
                    _NavBarItem(label: 'Services', section: 'services', provider: navProvider),
                    _NavBarItem(label: 'Work', section: 'work', provider: navProvider),
                    _NavBarItem(label: 'Process', section: 'process', provider: navProvider),
                    _NavBarItem(label: 'Testimonials', section: 'testimonials', provider: navProvider),
                    _NavBarItem(label: 'About', section: 'about', provider: navProvider),
                    const SizedBox(width: 24),
                    _ContactButton(navProvider: navProvider),
                  ],
                )
              else
                _MobileMenuButton(navProvider: navProvider),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatefulWidget {
  final String label;
  final String section;
  final HomeNavigationProvider provider;

  const _NavBarItem({
    required this.label,
    required this.section,
    required this.provider,
  });

  @override
  State<_NavBarItem> createState() => _NavBarItemState();
}

class _NavBarItemState extends State<_NavBarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.provider.activeSection == widget.section;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          if (mounted) setState(() => _isHovered = true);
        },
        onExit: (_) {
          if (mounted) setState(() => _isHovered = false);
        },
        child: GestureDetector(
          onTap: () => widget.provider.scrollTo(widget.section),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: GoogleFonts.inter(
                  color: isActive
                      ? AppColors.primaryText
                      : _isHovered
                          ? AppColors.primaryText
                          : AppColors.secondaryText,
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                ),
                child: Text(widget.label),
              ),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: isActive || _isHovered ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContactButton extends StatefulWidget {
  final HomeNavigationProvider navProvider;
  const _ContactButton({required this.navProvider});

  @override
  State<_ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<_ContactButton> {
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
        onTap: () => widget.navProvider.scrollTo('contact'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: _isHovered ? AppColors.accent : AppColors.primaryText,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Text(
            'Start a Project',
            style: GoogleFonts.inter(
              color: AppColors.background,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final HomeNavigationProvider navProvider;
  const _MobileMenuButton({required this.navProvider});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu_rounded, color: AppColors.primaryText),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.surface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (_) => _MobileMenu(navProvider: navProvider),
        );
      },
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final HomeNavigationProvider navProvider;
  const _MobileMenu({required this.navProvider});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Services', 'services'),
      ('Work', 'work'),
      ('Process', 'process'),
      ('Testimonials', 'testimonials'),
      ('About', 'about'),
      ('Contact', 'contact'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          ...items.map((item) => ListTile(
                title: Text(
                  item.$1,
                  style: GoogleFonts.inter(
                    color: AppColors.primaryText,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 14, color: AppColors.secondaryText),
                onTap: () {
                  Navigator.pop(context);
                  navProvider.scrollTo(item.$2);
                },
              )),
        ],
      ),
    );
  }
}
