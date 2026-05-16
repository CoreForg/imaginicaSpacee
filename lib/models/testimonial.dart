import 'package:cloud_firestore/cloud_firestore.dart';

class Testimonial {
  final String id;
  final String name;
  final String company;
  final String role;
  final String review;
  final int rating;
  final String? projectName;
  final bool isVerified;
  final bool isApproved;
  final bool isFeatured;
  final DateTime? submittedAt;

  const Testimonial({
    required this.id,
    required this.name,
    required this.company,
    required this.role,
    required this.review,
    required this.rating,
    this.projectName,
    this.isVerified = false,
    this.isApproved = false,
    this.isFeatured = false,
    this.submittedAt,
  });

  factory Testimonial.fromFirestore(String id, Map<String, dynamic> data) =>
      Testimonial(
        id: id,
        name: data['name'] as String? ?? '',
        company: data['company'] as String? ?? '',
        role: data['role'] as String? ?? '',
        review: data['review'] as String? ?? '',
        rating: data['rating'] as int? ?? 5,
        projectName: data['projectName'] as String?,
        isVerified: data['isVerified'] as bool? ?? false,
        isApproved: data['isApproved'] as bool? ?? false,
        isFeatured: data['isFeatured'] as bool? ?? false,
        submittedAt: (data['submittedAt'] as Timestamp?)?.toDate(),
      );

  Map<String, dynamic> toSubmitMap() => {
        'name': name,
        'company': company,
        'role': role,
        'review': review,
        'rating': rating,
        if (projectName != null) 'projectName': projectName,
        'isVerified': false,
        'isApproved': false,
        'isFeatured': false,
        'submittedAt': FieldValue.serverTimestamp(),
      };
}
