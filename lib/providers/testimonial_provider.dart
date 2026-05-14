import 'package:flutter/material.dart';

class Testimonial {
  final String id;
  final String name;
  final String company;
  final String role;
  final String review;
  final int rating;
  final String? projectName;
  final bool isVerified;
  bool isApproved;
  bool isFeatured;

  Testimonial({
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
  });
}

class TestimonialProvider extends ChangeNotifier {
  // Pre-seeded approved testimonials
  final List<Testimonial> _testimonials = [
    Testimonial(
      id: 't1',
      name: 'Sarah Jenkins',
      company: 'Nexus Technologies',
      role: 'Chief Technology Officer',
      review:
          'Imaginica Space delivered our MVP ahead of schedule. Their attention to detail and modern UI aesthetic really elevated our product. The scalable architecture they designed is still running flawlessly 18 months later.',
      rating: 5,
      projectName: 'HealthSync Mobile App',
      isVerified: true,
      isApproved: true,
      isFeatured: true,
    ),
    Testimonial(
      id: 't2',
      name: 'David Chen',
      company: 'HealthSync Inc.',
      role: 'Co-Founder & CEO',
      review:
          'A truly exceptional team. They handled our complex backend architecture with Firebase perfectly while maintaining a buttery-smooth Flutter frontend. The code quality and documentation were top-notch.',
      rating: 5,
      projectName: 'SaaS Analytics Dashboard',
      isVerified: true,
      isApproved: true,
      isFeatured: true,
    ),
    Testimonial(
      id: 't3',
      name: 'Anita Rao',
      company: 'Bloom Retail',
      role: 'Head of Product',
      review:
          'Working with Imaginica Space was the best decision we made. They understand not just code, but the business goals behind the features. Our e-commerce app saw a 38% drop in cart abandonment after the redesign.',
      rating: 5,
      projectName: 'E-Commerce Platform',
      isVerified: true,
      isApproved: true,
      isFeatured: false,
    ),
    Testimonial(
      id: 't4',
      name: 'Marcus Williams',
      company: 'TableTurn',
      role: 'Founder',
      review:
          'We needed a restaurant MVP in 6 weeks. Imaginica Space delivered in 5. The POS system and inventory management work seamlessly. They genuinely feel like an extension of our own team.',
      rating: 5,
      projectName: 'Restaurant Management MVP',
      isVerified: true,
      isApproved: true,
      isFeatured: false,
    ),
  ];

  final List<Testimonial> _pendingTestimonials = [];

  List<Testimonial> get approvedTestimonials =>
      _testimonials.where((t) => t.isApproved).toList();

  List<Testimonial> get featuredTestimonials =>
      _testimonials.where((t) => t.isApproved && t.isFeatured).toList();

  List<Testimonial> get pendingTestimonials => List.unmodifiable(_pendingTestimonials);

  List<Testimonial> get allTestimonials => [..._testimonials, ..._pendingTestimonials];

  void submitTestimonial({
    required String name,
    required String company,
    required String role,
    required String review,
    required int rating,
    String? projectName,
  }) {
    _pendingTestimonials.add(Testimonial(
      id: 'pending_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      company: company,
      role: role,
      review: review,
      rating: rating,
      projectName: projectName,
      isVerified: false,
      isApproved: false,
    ));
    notifyListeners();
  }

  void approveTestimonial(String id) {
    final idx = _pendingTestimonials.indexWhere((t) => t.id == id);
    if (idx != -1) {
      final t = _pendingTestimonials.removeAt(idx);
      t.isApproved = true;
      _testimonials.add(t);
      notifyListeners();
    }
  }

  void rejectTestimonial(String id) {
    _pendingTestimonials.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void deleteTestimonial(String id) {
    _testimonials.removeWhere((t) => t.id == id);
    _pendingTestimonials.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  void toggleFeatured(String id) {
    final t = _testimonials.firstWhere((t) => t.id == id);
    t.isFeatured = !t.isFeatured;
    notifyListeners();
  }
}
