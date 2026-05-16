import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/stat_item.dart';

class StatsService {
  static const _collection = 'site_config';
  static const _document = 'stats';

  static final _ref = FirebaseFirestore.instance
      .collection(_collection)
      .doc(_document);

  Stream<List<StatItem>> statsStream() {
    return _ref.snapshots().map((snap) {
      if (!snap.exists || snap.data() == null) return StatItem.defaults;
      final raw = snap.data()!['items'] as List<dynamic>?;
      if (raw == null || raw.isEmpty) return StatItem.defaults;
      final items = raw
          .asMap()
          .entries
          .map((e) => StatItem.fromMap(e.value as Map<String, dynamic>, e.key))
          .toList()
        ..sort((a, b) => a.order.compareTo(b.order));
      return items;
    });
  }

  Future<void> updateStats(List<StatItem> stats) => _ref.set({
        'items': stats.map((s) => s.toMap()).toList(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
}
