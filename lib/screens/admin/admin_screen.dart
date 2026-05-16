import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../models/stat_item.dart';
import '../../providers/stats_provider.dart';
import '../../providers/testimonial_provider.dart';
import '../../services/auth_service.dart';
import '../../services/stats_service.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primaryText),
          onPressed: () => context.go('/'),
        ),
        title: RichText(
          text: TextSpan(children: [
            TextSpan(text: 'Imaginica ', style: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w800, fontSize: 18)),
            TextSpan(text: 'Admin', style: GoogleFonts.inter(color: AppColors.accent, fontWeight: FontWeight.w800, fontSize: 18)),
          ]),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(color: AppColors.accent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.accent.withValues(alpha: 0.3))),
            child: Text('Admin Dashboard', style: GoogleFonts.inter(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout_rounded, color: AppColors.secondaryText, size: 20),
            onPressed: () {
              context.read<AuthService>().logout();
              context.go('/admin');
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            Container(
              color: AppColors.surface,
              child: TabBar(
                indicatorColor: AppColors.accent,
                labelColor: AppColors.primaryText,
                unselectedLabelColor: AppColors.secondaryText,
                labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600),
                tabs: const [
                  Tab(text: 'Pending Reviews'),
                  Tab(text: 'Approved Reviews'),
                  Tab(text: 'Site Stats'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _PendingTab(),
                  _ApprovedTab(),
                  _StatsTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PendingTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestimonialProvider>(context);
    final pending = provider.pendingTestimonials;

    if (pending.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inbox_rounded, size: 48, color: AppColors.mutedText),
            const SizedBox(height: 16),
            Text('No pending reviews', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 16)),
            const SizedBox(height: 8),
            Text('New submissions will appear here for moderation.', style: GoogleFonts.inter(color: AppColors.mutedText, fontSize: 13)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: pending.length,
      separatorBuilder: (context, i) => const SizedBox(height: 16),
      itemBuilder: (context, i) => _AdminCard(
        testimonial: pending[i],
        isPending: true,
        onApprove: () => provider.approveTestimonial(pending[i].id),
        onReject: () => provider.rejectTestimonial(pending[i].id),
      ),
    );
  }
}

class _ApprovedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TestimonialProvider>(context);
    final approved = provider.approvedTestimonials;

    if (approved.isEmpty) {
      return Center(child: Text('No approved reviews.', style: GoogleFonts.inter(color: AppColors.secondaryText)));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: approved.length,
      separatorBuilder: (context, i) => const SizedBox(height: 16),
      itemBuilder: (context, i) => _AdminCard(
        testimonial: approved[i],
        isPending: false,
        onToggleFeatured: () => provider.toggleFeatured(approved[i].id),
        onDelete: () => provider.deleteTestimonial(approved[i].id),
      ),
    );
  }
}

class _AdminCard extends StatelessWidget {
  final Testimonial testimonial;
  final bool isPending;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final VoidCallback? onToggleFeatured;
  final VoidCallback? onDelete;

  const _AdminCard({
    required this.testimonial,
    required this.isPending,
    this.onApprove,
    this.onReject,
    this.onToggleFeatured,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isPending ? AppColors.accentAmber.withValues(alpha: 0.3) : AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40, height: 40,
                decoration: const BoxDecoration(gradient: AppColors.accentGradient, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(testimonial.name[0], style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(testimonial.name, style: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w600)),
                    Text('${testimonial.role} · ${testimonial.company}', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 12)),
                  ],
                ),
              ),
              Row(
                children: List.generate(testimonial.rating, (_) => const Icon(Icons.star_rounded, color: Colors.amber, size: 14)),
              ),
              const SizedBox(width: 12),
              if (isPending)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.accentAmber.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text('Pending', style: GoogleFonts.inter(color: AppColors.accentAmber, fontSize: 11, fontWeight: FontWeight.w600)),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.accentGreen.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Text(testimonial.isFeatured ? 'Featured' : 'Approved', style: GoogleFonts.inter(color: AppColors.accentGreen, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text('"${testimonial.review}"', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 14, height: 1.5, fontStyle: FontStyle.italic)),
          if (testimonial.projectName != null) ...[
            const SizedBox(height: 8),
            Text('Project: ${testimonial.projectName}', style: GoogleFonts.inter(color: AppColors.mutedText, fontSize: 12)),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              if (isPending) ...[
                ElevatedButton.icon(
                  onPressed: onApprove,
                  icon: const Icon(Icons.check_rounded, size: 16),
                  label: Text('Approve', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.accentGreen, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: onReject,
                  icon: const Icon(Icons.close_rounded, size: 16),
                  label: Text('Reject', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
              ] else ...[
                OutlinedButton.icon(
                  onPressed: onToggleFeatured,
                  icon: Icon(testimonial.isFeatured ? Icons.star_rounded : Icons.star_outline_rounded, size: 16),
                  label: Text(testimonial.isFeatured ? 'Unfeature' : 'Feature', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                  style: OutlinedButton.styleFrom(foregroundColor: AppColors.accent, side: const BorderSide(color: AppColors.accent), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(width: 12),
                OutlinedButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline_rounded, size: 16),
                  label: Text('Delete', style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13)),
                  style: OutlinedButton.styleFrom(foregroundColor: Colors.red, side: const BorderSide(color: Colors.red), padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// ── Site Stats Tab ──────────────────────────────────────────────────────────

class _StatsTab extends StatefulWidget {
  @override
  State<_StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<_StatsTab> {
  final _service = StatsService();
  List<({TextEditingController value, TextEditingController label})>?
      _controllers;
  bool _isSaving = false;
  String? _savedMessage;

  @override
  void dispose() {
    if (_controllers != null) {
      for (final c in _controllers!) {
        c.value.dispose();
        c.label.dispose();
      }
    }
    super.dispose();
  }

  String? _errorMessage;

  Future<void> _save() async {
    if (_controllers == null) return;
    setState(() {
      _isSaving = true;
      _savedMessage = null;
      _errorMessage = null;
    });
    final updated = _controllers!
        .asMap()
        .entries
        .map((e) => StatItem(
              value: e.value.value.text.trim(),
              label: e.value.label.text.trim(),
              order: e.key,
            ))
        .toList();
    try {
      await _service.updateStats(updated);
      if (mounted) {
        setState(() {
          _isSaving = false;
          _savedMessage = 'Stats updated successfully';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSaving = false;
          _errorMessage = 'Save failed: ${e.toString()}';
        });
      }
    }
  }

  InputDecoration _fieldDecoration(String hint) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: AppColors.mutedText, fontSize: 13),
        filled: true,
        fillColor: AppColors.background,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<StatsProvider>().stats;
    _controllers ??= stats
        .map((s) => (
              value: TextEditingController(text: s.value),
              label: TextEditingController(text: s.label),
            ))
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hero Stats',
              style: GoogleFonts.inter(
                color: AppColors.primaryText,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'These numbers display in the stats card on the home page hero section.',
              style: GoogleFonts.inter(
                  color: AppColors.secondaryText, fontSize: 13),
            ),
            const SizedBox(height: 24),
            ...List.generate(_controllers!.length, (i) {
              final c = _controllers![i];
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stat ${i + 1}',
                      style: GoogleFonts.inter(
                        color: AppColors.mutedText,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SizedBox(
                          width: 110,
                          child: TextField(
                            controller: c.value,
                            style: GoogleFonts.inter(
                              color: AppColors.primaryText,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                            decoration: _fieldDecoration('e.g. 20+'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            controller: c.label,
                            style: GoogleFonts.inter(
                                color: AppColors.secondaryText, fontSize: 14),
                            decoration: _fieldDecoration('e.g. Projects Delivered'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 8),
            Row(
              children: [
                SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          AppColors.accent.withValues(alpha: 0.4),
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2),
                          )
                        : Text('Save Changes',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                  ),
                ),
                if (_savedMessage != null) ...[
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const Icon(Icons.check_circle_rounded,
                          color: AppColors.accentGreen, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        _savedMessage!,
                        style: GoogleFonts.inter(
                            color: AppColors.accentGreen, fontSize: 13),
                      ),
                    ],
                  ),
                ],
                if (_errorMessage != null) ...[
                  const SizedBox(width: 16),
                  Row(
                    children: [
                      const Icon(Icons.error_outline_rounded,
                          color: Colors.red, size: 16),
                      const SizedBox(width: 6),
                      Text(
                        _errorMessage!,
                        style: GoogleFonts.inter(
                            color: Colors.red, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
