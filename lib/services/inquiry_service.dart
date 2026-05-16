import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/inquiry.dart';

class InquiryService {
  static final _col = FirebaseFirestore.instance.collection('inquiries');

  Stream<List<Inquiry>> inquiriesStream() => _col
      .orderBy('submittedAt', descending: true)
      .snapshots()
      .map((s) =>
          s.docs.map((d) => Inquiry.fromFirestore(d.id, d.data())).toList());

  Future<void> submit(Inquiry inquiry) => _col.add(inquiry.toSubmitMap());

  Future<void> markRead(String id) =>
      _col.doc(id).update({'status': 'read'});

  Future<void> delete(String id) => _col.doc(id).delete();
}
