import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/testimonial.dart';

class TestimonialService {
  static final _col =
      FirebaseFirestore.instance.collection('testimonials');

  Stream<List<Testimonial>> pendingStream() => _col
      .where('isApproved', isEqualTo: false)
      .snapshots()
      .map((s) =>
          s.docs.map((d) => Testimonial.fromFirestore(d.id, d.data())).toList());

  Stream<List<Testimonial>> approvedStream() => _col
      .where('isApproved', isEqualTo: true)
      .snapshots()
      .map((s) =>
          s.docs.map((d) => Testimonial.fromFirestore(d.id, d.data())).toList());

  Future<void> submit(Testimonial t) => _col.add(t.toSubmitMap());

  Future<void> approve(String id) => _col.doc(id).update({
        'isApproved': true,
        'isVerified': true,
        'approvedAt': FieldValue.serverTimestamp(),
      });

  Future<void> reject(String id) => _col.doc(id).delete();

  Future<void> delete(String id) => _col.doc(id).delete();

  Future<void> toggleFeatured(String id) async {
    final snap = await _col.doc(id).get();
    final current = snap.data()?['isFeatured'] as bool? ?? false;
    await _col.doc(id).update({'isFeatured': !current});
  }
}
