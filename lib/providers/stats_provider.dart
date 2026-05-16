import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/stat_item.dart';
import '../services/stats_service.dart';

class StatsProvider extends ChangeNotifier {
  final _service = StatsService();

  // Start with defaults so the hero section never shows empty while loading
  List<StatItem> _stats = StatItem.defaults;
  StreamSubscription<List<StatItem>>? _sub;

  StatsProvider() {
    _sub = _service.statsStream().listen((stats) {
      _stats = stats;
      notifyListeners();
    });
  }

  List<StatItem> get stats => _stats;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
