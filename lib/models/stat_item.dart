class StatItem {
  final String value;
  final String label;
  final int order;

  const StatItem({
    required this.value,
    required this.label,
    required this.order,
  });

  factory StatItem.fromMap(Map<String, dynamic> map, int order) => StatItem(
        value: (map['value'] as String?) ?? '',
        label: (map['label'] as String?) ?? '',
        order: (map['order'] as int?) ?? order,
      );

  Map<String, dynamic> toMap() => {
        'value': value,
        'label': label,
        'order': order,
      };

  StatItem copyWith({String? value, String? label, int? order}) => StatItem(
        value: value ?? this.value,
        label: label ?? this.label,
        order: order ?? this.order,
      );

  static const List<StatItem> defaults = [
    StatItem(value: '20+', label: 'Projects Delivered', order: 0),
    StatItem(value: '15+', label: 'Happy Clients', order: 1),
    StatItem(value: '3+', label: 'Years Experience', order: 2),
    StatItem(value: '99%', label: 'Client Satisfaction', order: 3),
  ];
}
