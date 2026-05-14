import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw Exception('Could not launch $url');
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 100),
      color: AppColors.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(40),
            decoration: BoxDecoration(
              color: AppColors.surfaceHighlight.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Text('Let\'s Build Something\nAmazing Together', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: isMobile ? 32 : 52, fontWeight: FontWeight.bold, letterSpacing: -1, height: 1.15), textAlign: TextAlign.center).animate().fadeIn().slideY(begin: 0.1),
                const SizedBox(height: 20),
                Text('Have a project in mind? Tell us about it — we\'d love to help bring your idea to life.', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: isMobile ? 16 : 18, height: 1.5), textAlign: TextAlign.center).animate().fadeIn(delay: 100.ms),
                const SizedBox(height: 48),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => showDialog(context: context, builder: (_) => const _InquiryModal()),
                      icon: const Icon(Icons.rocket_launch_rounded, size: 18),
                      label: Text('Start Your Project', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => showDialog(context: context, builder: (_) => const _BookingModal()),
                      icon: const Icon(Icons.calendar_today_rounded, size: 18),
                      label: Text('Book a Call', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryText, foregroundColor: AppColors.background, padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    ),
                    OutlinedButton.icon(
                      onPressed: () => _launch('https://wa.me/919990414670'),
                      icon: const Icon(Icons.chat_rounded, size: 18),
                      label: Text('WhatsApp', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                      style: OutlinedButton.styleFrom(foregroundColor: const Color(0xFF25D366), side: const BorderSide(color: Color(0xFF25D366)), padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                    ),
                  ],
                ).animate().fadeIn(delay: 200.ms),
                const SizedBox(height: 32),
                Text('or email us directly at', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 14)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () => _launch('mailto:Prasonjena2912@gmail.com'),
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Text('Prasonjena2912@gmail.com', style: GoogleFonts.inter(color: AppColors.accent, fontSize: 16, fontWeight: FontWeight.w600, decoration: TextDecoration.underline, decorationColor: AppColors.accent)),
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

class _InquiryModal extends StatefulWidget {
  const _InquiryModal();
  @override
  State<_InquiryModal> createState() => _InquiryModalState();
}

class _InquiryModalState extends State<_InquiryModal> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  String _service = 'Mobile App Development';
  String _budget = '\$5k–\$15k';
  String _timeline = '1–3 months';
  bool _submitted = false;

  static const _services = ['Mobile App Development', 'SaaS Platform', 'Web Development', 'AI-Powered Product', 'Startup MVP', 'UI/UX Design', 'Backend / Firebase'];
  static const _budgets = ['< \$5k', '\$5k–\$15k', '\$15k–\$50k', '\$50k+', 'Let\'s discuss'];
  static const _timelines = ['< 1 month', '1–3 months', '3–6 months', '6+ months', 'Flexible'];

  InputDecoration _dec(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: AppColors.mutedText, fontSize: 14),
        filled: true, fillColor: AppColors.background,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.accent)),
      );

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 13, fontWeight: FontWeight.w500)),
      );

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 580,
        padding: const EdgeInsets.all(32),
        child: _submitted
            ? Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: 16),
                Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: AppColors.accentGreen.withValues(alpha: 0.1), shape: BoxShape.circle), child: const Icon(Icons.check_circle_rounded, color: AppColors.accentGreen, size: 48)),
                const SizedBox(height: 24),
                Text('Inquiry Received!', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text('We\'ll get back to you within 24 hours. Expect a reply at your email shortly.', textAlign: TextAlign.center, style: GoogleFonts.inter(color: AppColors.secondaryText, height: 1.5)),
                const SizedBox(height: 28),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text('Done', style: GoogleFonts.inter(fontWeight: FontWeight.w600)))),
              ])
            : SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Start Your Project', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 22, fontWeight: FontWeight.bold)),
                    IconButton(icon: const Icon(Icons.close, color: AppColors.secondaryText), onPressed: () => Navigator.pop(context)),
                  ]),
                  const SizedBox(height: 24),
                  _label('Your Name'), TextField(controller: _name, decoration: _dec('Full name'), style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14)),
                  const SizedBox(height: 16),
                  _label('Email Address'), TextField(controller: _email, decoration: _dec('you@company.com'), style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14)),
                  const SizedBox(height: 16),
                  _label('Service Needed'),
                  DropdownButtonFormField<String>(
                    initialValue: _service,
                    dropdownColor: AppColors.surface,
                    decoration: _dec(''),
                    style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14),
                    items: _services.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (v) => setState(() => _service = v!),
                  ),
                  const SizedBox(height: 16),
                  Row(children: [
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      _label('Budget Range'),
                      DropdownButtonFormField<String>(
                        initialValue: _budget,
                        dropdownColor: AppColors.surface,
                        decoration: _dec(''),
                        style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14),
                        items: _budgets.map((b) => DropdownMenuItem(value: b, child: Text(b))).toList(),
                        onChanged: (v) => setState(() => _budget = v!),
                      ),
                    ])),
                    const SizedBox(width: 16),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      _label('Timeline'),
                      DropdownButtonFormField<String>(
                        initialValue: _timeline,
                        dropdownColor: AppColors.surface,
                        decoration: _dec(''),
                        style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14),
                        items: _timelines.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                        onChanged: (v) => setState(() => _timeline = v!),
                      ),
                    ])),
                  ]),
                  const SizedBox(height: 16),
                  _label('Project Details'), TextField(controller: _message, maxLines: 4, decoration: _dec('Tell us about your project...'), style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14)),
                  const SizedBox(height: 28),
                  SizedBox(width: double.infinity, child: ElevatedButton(
                    onPressed: () {
                      if (_name.text.isEmpty || _email.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill in your name and email.')));
                        return;
                      }
                      setState(() => _submitted = true);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    child: Text('Send Inquiry', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                  )),
                ]),
              ),
      ),
    );
  }
}

class _BookingModal extends StatefulWidget {
  const _BookingModal();
  @override
  State<_BookingModal> createState() => _BookingModalState();
}

class _BookingModalState extends State<_BookingModal> {
  int _selectedDay = -1;
  int _selectedTime = -1;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Book a Discovery Call', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 22, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.close, color: AppColors.secondaryText), onPressed: () => Navigator.pop(context)),
            ]),
            const SizedBox(height: 8),
            Text('Free 30-minute consultation to discuss your project.', style: GoogleFonts.inter(color: AppColors.secondaryText)),
            const SizedBox(height: 32),
            Text('Select a Day', style: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12, runSpacing: 12,
              children: List.generate(5, (i) {
                final date = DateTime.now().add(Duration(days: i + 1));
                final isSelected = _selectedDay == i;
                return GestureDetector(
                  onTap: () => setState(() { _selectedDay = i; _selectedTime = -1; }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(color: isSelected ? AppColors.accent : AppColors.surfaceHighlight, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSelected ? AppColors.accent : AppColors.border)),
                    child: Column(children: [
                      Text(['Mon','Tue','Wed','Thu','Fri','Sat','Sun'][date.weekday - 1], style: GoogleFonts.inter(color: isSelected ? Colors.white : AppColors.secondaryText, fontSize: 12)),
                      Text('${date.day}', style: GoogleFonts.inter(color: isSelected ? Colors.white : AppColors.primaryText, fontSize: 20, fontWeight: FontWeight.bold)),
                    ]),
                  ),
                );
              }),
            ),
            if (_selectedDay != -1) ...[
              const SizedBox(height: 24),
              Text('Available Times', style: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w600)),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12, runSpacing: 12,
                children: ['10:00 AM', '1:00 PM', '3:30 PM', '5:00 PM'].asMap().entries.map((e) {
                  final isSelected = _selectedTime == e.key;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedTime = e.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(color: isSelected ? AppColors.accent : Colors.transparent, borderRadius: BorderRadius.circular(20), border: Border.all(color: isSelected ? AppColors.accent : AppColors.border)),
                      child: Text(e.value, style: GoogleFonts.inter(color: isSelected ? Colors.white : AppColors.primaryText)),
                    ),
                  );
                }).toList(),
              ),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedTime != -1 ? () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Discovery call booked! A calendar invite will be sent shortly.')));
                } : null,
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryText, disabledBackgroundColor: AppColors.surfaceHighlight, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: Text('Confirm Booking', style: GoogleFonts.inter(fontWeight: FontWeight.w600, color: _selectedTime != -1 ? AppColors.background : AppColors.secondaryText)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
