import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw Exception('Could not launch $url');
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 48),
      color: AppColors.background,
      child: Column(
        children: [
          const Divider(color: AppColors.border),
          const SizedBox(height: 40),
          isMobile
              ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _LogoBlock(),
                  const SizedBox(height: 32),
                  _LinkColumns(launch: _launch),
                  const SizedBox(height: 32),
                  _SocialRow(launch: _launch),
                ])
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: _LogoBlock()),
                    Expanded(flex: 3, child: _LinkColumns(launch: _launch)),
                    _SocialRow(launch: _launch),
                  ],
                ),
          const SizedBox(height: 40),
          const Divider(color: AppColors.border),
          const SizedBox(height: 24),
          isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '© 2026 Imaginica Space. All rights reserved.',
                      style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 13),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Building digital products for the future.',
                      style: GoogleFonts.inter(
                        color: AppColors.mutedText,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '© 2026 Imaginica Space. All rights reserved.',
                          style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 13),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Building digital products for the future.',
                          style: GoogleFonts.inter(
                            color: AppColors.mutedText,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    Text('imaginica.space', style: GoogleFonts.inter(color: AppColors.mutedText, fontSize: 13)),
                  ],
                ),
        ],
      ),
    );
  }
}

class _LogoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(children: [
            TextSpan(text: 'Imaginica', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 20, fontWeight: FontWeight.w800)),
            TextSpan(text: ' Space', style: GoogleFonts.inter(color: AppColors.accent, fontSize: 20, fontWeight: FontWeight.w800)),
          ]),
        ),
        const SizedBox(height: 12),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 240),
          child: Text(
            'Modern digital products for startups and businesses.',
            style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 14, height: 1.5),
          ),
        ),
        const SizedBox(height: 16),
        Text('Prasonjena2912@gmail.com', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 13)),
        const SizedBox(height: 4),
        Text('+91 9990414670', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 13)),
      ],
    );
  }
}

class _LinkColumns extends StatelessWidget {
  final Future<void> Function(String) launch;
  const _LinkColumns({required this.launch});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 40,
        runSpacing: 24,
        children: [
          _LinkGroup(title: 'Services', links: const [
            ('Mobile Apps', null), ('SaaS Platforms', null),
            ('Full Stack', null), ('AI Products', null), ('UI/UX Design', null),
          ], launch: launch),
          _LinkGroup(title: 'Company', links: const [
            ('About Us', null), ('Our Work', null),
            ('Process', null), ('Testimonials', null),
          ], launch: launch),
          _LinkGroup(title: 'Connect', links: [
            ('GitHub', 'https://github.com/PrasonJena'),
            ('LinkedIn', 'https://linkedin.com/in/PrasonJena'),
            ('Email Us', 'mailto:Prasonjena2912@gmail.com'),
            ('WhatsApp', 'https://wa.me/919990414670'),
          ], launch: launch),
        ],
      ),
    );
  }
}

class _LinkGroup extends StatelessWidget {
  final String title;
  final List<(String, String?)> links;
  final Future<void> Function(String) launch;

  const _LinkGroup({required this.title, required this.links, required this.launch});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        ...links.map((l) => _FooterLink(label: l.$1, url: l.$2, launch: launch)),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final String? url;
  final Future<void> Function(String) launch;

  const _FooterLink({required this.label, required this.url, required this.launch});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: MouseRegion(
        cursor: widget.url != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) {
          if (mounted) setState(() => _isHovered = true);
        },
        onExit: (_) {
          if (mounted) setState(() => _isHovered = false);
        },
        child: GestureDetector(
          onTap: widget.url != null ? () => widget.launch(widget.url!) : null,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: GoogleFonts.inter(
              color: _isHovered ? AppColors.primaryText : AppColors.secondaryText,
              fontSize: 14,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _SocialRow extends StatelessWidget {
  final Future<void> Function(String) launch;
  const _SocialRow({required this.launch});

  @override
  Widget build(BuildContext context) {
    final socials = [
      (Icons.code_rounded, 'https://github.com/PrasonJena'),
      (Icons.link_rounded, 'https://linkedin.com/in/PrasonJena'),
      (Icons.email_rounded, 'mailto:Prasonjena2912@gmail.com'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Connect', style: GoogleFonts.inter(color: AppColors.mutedText, fontSize: 12, letterSpacing: 0.8, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Row(
          children: socials.map((s) => _SocialIcon(icon: s.$1, url: s.$2, launch: launch)).toList(),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  final Future<void> Function(String) launch;

  const _SocialIcon({required this.icon, required this.url, required this.launch});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          if (mounted) setState(() => _isHovered = true);
        },
        onExit: (_) {
          if (mounted) setState(() => _isHovered = false);
        },
        child: GestureDetector(
          onTap: () => widget.launch(widget.url),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _isHovered ? AppColors.surfaceHighlight : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _isHovered ? AppColors.border : Colors.transparent),
            ),
            child: Icon(widget.icon, color: _isHovered ? AppColors.primaryText : AppColors.secondaryText, size: 18),
          ),
        ),
      ),
    );
  }
}
