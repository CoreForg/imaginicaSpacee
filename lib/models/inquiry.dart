import 'package:cloud_firestore/cloud_firestore.dart';

class Inquiry {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String service;
  final String budget;
  final String timeline;
  final String message;
  final String status; // 'new' | 'read' | 'archived'
  final DateTime? submittedAt;

  const Inquiry({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.service,
    required this.budget,
    required this.timeline,
    required this.message,
    this.status = 'new',
    this.submittedAt,
  });

  bool get isNew => status == 'new';

  factory Inquiry.fromFirestore(String id, Map<String, dynamic> d) => Inquiry(
        id: id,
        name: d['name'] as String? ?? '',
        email: d['email'] as String? ?? '',
        phone: d['phone'] as String? ?? '',
        service: d['service'] as String? ?? '',
        budget: d['budget'] as String? ?? '',
        timeline: d['timeline'] as String? ?? '',
        message: d['message'] as String? ?? '',
        status: d['status'] as String? ?? 'new',
        submittedAt: (d['submittedAt'] as Timestamp?)?.toDate(),
      );

  Map<String, dynamic> toSubmitMap() => {
        'name': name,
        'email': email,
        'phone': phone,
        'service': service,
        'budget': budget,
        'timeline': timeline,
        'message': message,
        'status': 'new',
        'submittedAt': FieldValue.serverTimestamp(),
      };
}
