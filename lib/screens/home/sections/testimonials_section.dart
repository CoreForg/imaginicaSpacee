import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../providers/testimonial_provider.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final testimonials = Provider.of<TestimonialProvider>(context).approvedTestimonials;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 80),
      color: AppColors.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Client Testimonials', style: GoogleFonts.inter(color: AppColors.accent, fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 1.5)).animate().fadeIn(),
          const SizedBox(height: 16),
          Text('What Our Clients Say', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: isMobile ? 32 : 48, fontWeight: FontWeight.bold, letterSpacing: -1)).animate().fadeIn(delay: 100.ms),
          const SizedBox(height: 12),
          Text('Real feedback — unfiltered and verified.', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 16)).animate().fadeIn(delay: 150.ms),
          const SizedBox(height: 48),
          isMobile
              ? Column(children: testimonials.map((t) => Padding(padding: const EdgeInsets.only(bottom: 20), child: _TestimonialCard(t: t))).toList())
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20, childAspectRatio: 1.6),
                  itemCount: testimonials.length,
                  itemBuilder: (ctx, i) => _TestimonialCard(t: testimonials[i]).animate().fadeIn(delay: (i * 100).ms).slideY(begin: 0.1),
                ),
          const SizedBox(height: 48),
          OutlinedButton.icon(
            onPressed: () => showDialog(context: context, builder: (_) => const _ReviewFormDialog()),
            style: OutlinedButton.styleFrom(foregroundColor: AppColors.primaryText, side: const BorderSide(color: AppColors.border), padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
            icon: const Icon(Icons.rate_review_rounded, size: 18),
            label: Text('Leave a Review', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
          ).animate().fadeIn(delay: 200.ms),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Testimonial t;
  const _TestimonialCard({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: List.generate(t.rating, (_) => const Padding(padding: EdgeInsets.only(right: 2), child: Icon(Icons.star_rounded, color: Colors.amber, size: 16)))),
          const SizedBox(height: 16),
          Expanded(
            child: Text('"${t.review}"', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 14, height: 1.6, fontStyle: FontStyle.italic), overflow: TextOverflow.fade),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                width: 42, height: 42,
                decoration: const BoxDecoration(gradient: AppColors.accentGradient, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(t.name[0], style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(t.name, style: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w600, fontSize: 14)),
                        if (t.isVerified) ...[const SizedBox(width: 6), const Icon(Icons.verified_rounded, color: AppColors.accent, size: 14)],
                      ],
                    ),
                    Text('${t.role} · ${t.company}', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 12), overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ],
          ),
          if (t.projectName != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: AppColors.surfaceHighlight, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
              child: Text(t.projectName!, style: GoogleFonts.inter(color: AppColors.mutedText, fontSize: 11, fontWeight: FontWeight.w500)),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReviewFormDialog extends StatefulWidget {
  const _ReviewFormDialog();
  @override
  State<_ReviewFormDialog> createState() => _ReviewFormDialogState();
}

class _ReviewFormDialogState extends State<_ReviewFormDialog> {
  final _name = TextEditingController();
  final _company = TextEditingController();
  final _role = TextEditingController();
  final _review = TextEditingController();
  final _project = TextEditingController();
  int _rating = 5;
  bool _submitted = false;

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: AppColors.mutedText, fontSize: 14),
        filled: true,
        fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.accent)),
      );

  void _submit() {
    if (_name.text.isEmpty || _company.text.isEmpty || _review.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill required fields.')));
      return;
    }
    Provider.of<TestimonialProvider>(context, listen: false).submitTestimonial(
      name: _name.text, company: _company.text, role: _role.text,
      review: _review.text, rating: _rating,
      projectName: _project.text.isEmpty ? null : _project.text,
    );
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 520,
        padding: const EdgeInsets.all(32),
        child: _submitted
            ? Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: 16),
                Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.accentGreen.withValues(alpha: 0.1), shape: BoxShape.circle), child: const Icon(Icons.check_circle_rounded, color: AppColors.accentGreen, size: 48)),
                const SizedBox(height: 24),
                Text('Thank You!', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text('Your review has been submitted and will be published after verification.', textAlign: TextAlign.center, style: GoogleFonts.inter(color: AppColors.secondaryText, height: 1.5)),
                const SizedBox(height: 28),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text('Close', style: GoogleFonts.inter(fontWeight: FontWeight.w600)))),
              ])
            : Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Leave a Review', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 22, fontWeight: FontWeight.bold)),
                  IconButton(icon: const Icon(Icons.close, color: AppColors.secondaryText), onPressed: () => Navigator.pop(context)),
                ]),
                const SizedBox(height: 4),
                Text('Submitted reviews are verified before publishing.', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 13)),
                const SizedBox(height: 20),
                Row(children: List.generate(5, (i) => GestureDetector(onTap: () => setState(() => _rating = i + 1), child: Icon(i < _rating ? Icons.star_rounded : Icons.star_outline_rounded, color: Colors.amber, size: 28)))),
                const SizedBox(height: 16),
                TextField(controller: _name, decoration: _dec('Your Name *'), style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14)),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: TextField(controller: _company, decoration: _dec('Company *'), style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14))),
                  const SizedBox(width: 12),
                  Expanded(child: TextField(controller: _role, decoration: _dec('Your Role'), style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14))),
                ]),
                const SizedBox(height: 12),
                TextField(controller: _project, decoration: _dec('Project Name (optional)'), style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14)),
                const SizedBox(height: 12),
                TextField(controller: _review, maxLines: 4, decoration: _dec('Your Review *'), style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14)),
                const SizedBox(height: 24),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _submit, style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text('Submit for Review', style: GoogleFonts.inter(fontWeight: FontWeight.w600)))),
              ]),
      ),
    );
  }
}
