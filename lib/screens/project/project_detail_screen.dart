import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive.dart';
import '../../models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App bar
          SliverAppBar(
            backgroundColor: AppColors.surface,
            pinned: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primaryText),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Case Study',
              style: GoogleFonts.inter(color: AppColors.primaryText, fontWeight: FontWeight.w600),
            ),
            actions: [
              // Platform badges
              if (project.platforms.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: project.platforms.map((p) => Container(
                      margin: const EdgeInsets.only(left: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        p,
                        style: GoogleFonts.inter(color: AppColors.accent, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    )).toList(),
                  ),
                )
              else
                Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    'Imaginica Space',
                    style: GoogleFonts.inter(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
            ],
          ),

          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 60),
                  color: AppColors.surface,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8, runSpacing: 8,
                        children: project.categories.map((c) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.accent.withValues(alpha: 0.2)),
                          ),
                          child: Text(c, style: GoogleFonts.inter(color: AppColors.accent, fontSize: 12, fontWeight: FontWeight.w600)),
                        )).toList(),
                      ).animate().fadeIn(),
                      const SizedBox(height: 20),
                      Text(
                        project.title,
                        style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: isMobile ? 32 : 52, fontWeight: FontWeight.bold, letterSpacing: -1),
                      ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
                      const SizedBox(height: 12),
                      Text(
                        project.tagline,
                        style: GoogleFonts.inter(color: AppColors.accent, fontSize: 18, fontWeight: FontWeight.w500),
                      ).animate().fadeIn(delay: 150.ms),
                      const SizedBox(height: 16),
                      Text(
                        project.overview,
                        style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 16, height: 1.6),
                      ).animate().fadeIn(delay: 200.ms),
                    ],
                  ),
                ),

                // ── Media Section ─────────────────────────────
                if (project.screenshots.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
                    child: _SectionLabel(
                      title: project.categories.contains('Mobile Apps') && !project.platforms.contains('Web') 
                          ? 'Live Screenshots — App' 
                          : 'Live Screenshots — Web',
                      icon: project.categories.contains('Mobile Apps') && !project.platforms.contains('Web')
                          ? Icons.smartphone_rounded 
                          : Icons.web_rounded,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ScreenshotGallery(
                    screenshots: project.screenshots,
                    isMobile: isMobile,
                    isMobileScreenshots: project.categories.contains('Mobile Apps') && !project.platforms.contains('Web'),
                  ).animate().fadeIn(delay: 250.ms),
                ],

                if (project.videoPath != null) ...[
                  const SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
                    child: const _SectionLabel(
                      title: 'Product Walkthrough Video',
                      icon: Icons.play_circle_outline_rounded,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
                    child: _VideoPlayer(videoPath: project.videoPath!),
                  ).animate().fadeIn(delay: 300.ms),
                ],

                // Placeholder banner for projects without media
                if (project.screenshots.isEmpty && project.videoPath == null)
                  Container(
                    width: double.infinity,
                    height: isMobile ? 220 : 360,
                    margin: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80, vertical: 32),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.accent.withValues(alpha: 0.15), AppColors.surfaceHighlight],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.auto_awesome_rounded, size: 48, color: AppColors.accent.withValues(alpha: 0.4)),
                          const SizedBox(height: 12),
                          Text('Project Preview', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 14)),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 300.ms).scale(begin: const Offset(0.96, 0.96)),

                // ── Detailed content ─────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 80),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      _DetailSection(title: 'The Problem', content: project.problem, icon: Icons.help_outline_rounded),
                      const SizedBox(height: 32),
                      _DetailSection(title: 'Our Solution', content: project.solution, icon: Icons.lightbulb_outline_rounded),
                      const SizedBox(height: 32),

                      // Features
                      _SectionLabel(title: 'Key Features', icon: Icons.check_circle_outline_rounded),
                      const SizedBox(height: 16),
                      ...project.features.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              width: 6, height: 6,
                              decoration: const BoxDecoration(color: AppColors.accent, shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Text(e.value, style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 15, height: 1.5))),
                          ],
                        ).animate().fadeIn(delay: (e.key * 60).ms),
                      )),
                      const SizedBox(height: 32),
                      _DetailSection(title: 'Architecture & Workflow', content: project.architecture, icon: Icons.architecture_rounded),
                      const SizedBox(height: 32),
                      _DetailSection(title: 'Results & Impact', content: project.results, icon: Icons.trending_up_rounded),
                      const SizedBox(height: 32),

                      // Tech stack
                      _SectionLabel(title: 'Technologies Used', icon: Icons.code_rounded),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10, runSpacing: 10,
                        children: project.techStack.map((t) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceHighlight,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Text(t, style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 14, fontWeight: FontWeight.w500)),
                        )).toList(),
                      ).animate().fadeIn(delay: 100.ms),
                      const SizedBox(height: 48),

                      // CTA
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          children: [
                            Text('Interested in a Similar Project?', style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 12),
                            Text('Let\'s discuss how Imaginica Space can build your next product.', style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 15), textAlign: TextAlign.center),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.accent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: Text('Start Your Project', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                      const SizedBox(height: 60),
                    ],
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

// ── Screenshot Gallery ─────────────────────────────────────────────────────

class _ScreenshotGallery extends StatefulWidget {
  final List<String> screenshots;
  final bool isMobile;
  final bool isMobileScreenshots;
  const _ScreenshotGallery({required this.screenshots, required this.isMobile, this.isMobileScreenshots = false});

  @override
  State<_ScreenshotGallery> createState() => _ScreenshotGalleryState();
}

class _ScreenshotGalleryState extends State<_ScreenshotGallery> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main preview
        GestureDetector(
          onTap: () => _showFullscreen(context, widget.screenshots[_selected]),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              height: widget.isMobile ? (widget.isMobileScreenshots ? 400 : 200) : (widget.isMobileScreenshots ? 600 : 480),
              margin: EdgeInsets.symmetric(horizontal: widget.isMobile ? 20 : 80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
                color: AppColors.surfaceHighlight,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: Image.asset(
                        widget.screenshots[_selected],
                        key: ValueKey(_selected),
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Center(
                          child: Icon(Icons.broken_image_rounded, color: AppColors.mutedText, size: 48),
                        ),
                      ),
                    ),
                    // Fullscreen hint
                    Positioned(
                      top: 12, right: 12,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: const Icon(Icons.fullscreen_rounded, color: AppColors.secondaryText, size: 16),
                      ),
                    ),
                    // Counter
                    Positioned(
                      bottom: 12, right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.background.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Text(
                          '${_selected + 1} / ${widget.screenshots.length}',
                          style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Thumbnail strip
        SizedBox(
          height: 70,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 20 : 80),
            itemCount: widget.screenshots.length,
            itemBuilder: (ctx, i) {
              final isActive = i == _selected;
              return GestureDetector(
                onTap: () => setState(() => _selected = i),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 110,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isActive ? AppColors.accent : AppColors.border,
                        width: isActive ? 2 : 1,
                      ),
                      boxShadow: isActive ? [BoxShadow(color: AppColors.accent.withValues(alpha: 0.25), blurRadius: 8)] : [],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9),
                      child: Image.asset(
                        widget.screenshots[i],
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceHighlight),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showFullscreen(BuildContext context, String assetPath) {
    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(24),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(assetPath, fit: BoxFit.contain),
            ),
            Positioned(
              top: 8, right: 8,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.background.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Icon(Icons.close_rounded, color: AppColors.primaryText, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Video Player ──────────────────────────────────────────────────────────

class _VideoPlayer extends StatefulWidget {
  final String videoPath;
  const _VideoPlayer({required this.videoPath});

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        if (mounted) setState(() => _initialized = true);
      }).catchError((_) {
        if (mounted) setState(() => _error = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: _error
          ? Container(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.videocam_off_rounded, color: AppColors.mutedText, size: 40),
                    const SizedBox(height: 12),
                    Text(
                      _controller.value.errorDescription ?? 'Video unavailable in preview mode.',
                      style: GoogleFonts.inter(color: AppColors.mutedText, fontSize: 13),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : !_initialized
              ? Container(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(color: AppColors.accent, strokeWidth: 2),
                  ),
                )
              : Column(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                    Container(
                      color: AppColors.surface,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                            child: MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.accent.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppColors.accent.withValues(alpha: 0.3)),
                                ),
                                child: Icon(
                                  _controller.value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                  color: AppColors.accent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: VideoProgressColors(
                                playedColor: AppColors.accent,
                                bufferedColor: AppColors.surfaceHighlight,
                                backgroundColor: AppColors.border,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          ValueListenableBuilder<VideoPlayerValue>(
                            valueListenable: _controller,
                            builder: (_, val, __) {
                              final pos = val.position;
                              final dur = val.duration;
                              String fmt(Duration d) =>
                                  '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
                              return Text(
                                '${fmt(pos)} / ${fmt(dur)}',
                                style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 12),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}

// ── Shared widgets ────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String title;
  final IconData icon;
  const _SectionLabel({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent, size: 20),
        const SizedBox(width: 10),
        Text(title, style: GoogleFonts.inter(color: AppColors.primaryText, fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    ).animate().fadeIn().slideX(begin: -0.05);
  }
}

class _DetailSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  const _DetailSection({required this.title, required this.content, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(title: title, icon: icon),
        const SizedBox(height: 14),
        Text(content, style: GoogleFonts.inter(color: AppColors.secondaryText, fontSize: 16, height: 1.7)),
      ],
    );
  }
}
