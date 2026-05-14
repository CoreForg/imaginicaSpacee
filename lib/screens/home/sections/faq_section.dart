import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final faqs = [
      {'q': 'What are your typical project timelines?', 'a': 'Timelines vary based on scope. An MVP typically takes 4–8 weeks, while full-scale platforms take 3–6 months. We always align on realistic milestones upfront.'},
      {'q': 'What is your pricing structure?', 'a': 'We offer both fixed-price project models and monthly retainer arrangements. We are transparent about costs from day one — no surprises.'},
      {'q': 'Do you provide support after deployment?', 'a': 'Yes. We offer ongoing maintenance and support packages to ensure your application runs smoothly and scales confidently post-launch.'},
      {'q': 'Will you handle app publishing to stores?', 'a': 'Absolutely. We handle the complete deployment process — iOS App Store, Google Play, and web hosting — ensuring a smooth go-live.'},
      {'q': 'How do you handle backend and server management?', 'a': 'We typically use Firebase or custom Node.js/Spring Boot servers with PostgreSQL. We can also handle AWS and GCP deployments based on your infrastructure needs.'},
    ];

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: 80,
      ),
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'FAQ',
            style: GoogleFonts.inter(
              color: AppColors.accent,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
            ),
          ).animate().fadeIn(),
          const SizedBox(height: 16),
          Text(
            'Common Questions',
            style: GoogleFonts.inter(
              color: AppColors.primaryText,
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              letterSpacing: -1,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 48),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: faqs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                return _FAQItem(
                  question: faqs[index]['q']!,
                  answer: faqs[index]['a']!,
                ).animate().fadeIn(delay: (100 + index * 50).ms);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem> {
  // ignore: unused_field
  final bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(
            widget.question,
            style: GoogleFonts.inter(
              color: AppColors.primaryText,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          iconColor: AppColors.accent,
          collapsedIconColor: AppColors.secondaryText,
          childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
          onExpansionChanged: (_) {},
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.answer,
                style: GoogleFonts.inter(
                  color: AppColors.secondaryText,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
