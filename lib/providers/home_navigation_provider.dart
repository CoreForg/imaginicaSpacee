import 'package:flutter/material.dart';

class HomeNavigationProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  final Map<String, GlobalKey> sectionKeys = {
    'hero': GlobalKey(),
    'services': GlobalKey(),
    'work': GlobalKey(),
    'process': GlobalKey(),
    'testimonials': GlobalKey(),
    'about': GlobalKey(),
    'contact': GlobalKey(),
  };

  String activeSection = 'hero';
  bool isScrolled = false;
  String activeProjectFilter = 'All';

  HomeNavigationProvider() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.hasClients) {
      final offset = scrollController.offset;

      if (offset > 50 && !isScrolled) {
        isScrolled = true;
        notifyListeners();
      } else if (offset <= 50 && isScrolled) {
        isScrolled = false;
        notifyListeners();
      }

      // Update active section based on scroll position
      _updateActiveSection();
    }
  }

  void _updateActiveSection() {
    for (final entry in sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;
      final pos = box.localToGlobal(Offset.zero);
      if (pos.dy <= 120 && pos.dy + box.size.height > 0) {
        if (activeSection != entry.key) {
          activeSection = entry.key;
          notifyListeners();
        }
        break;
      }
    }
  }

  void scrollTo(String sectionName) {
    final key = sectionKeys[sectionName];
    if (key != null && key.currentContext != null) {
      activeSection = sectionName;
      notifyListeners();
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void filterProjects(String filter) {
    activeProjectFilter = filter;
    notifyListeners();
    scrollTo('work');
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
