import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidad.dart';

class UniversidadService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('universidades');

  Stream<List<Universidad>> streamUniversidades() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Universidad.fromJson(data, doc.id);
      }).toList();
    });
  }

  Future<void> addUniversidad(Universidad universidad) async {
    await _collection.add(universidad.toJson());
  }

  Future<void> updateUniversidad(
    String id,
    Universidad universidad,
  ) async {
    await _collection.doc(id).update(universidad.toJson());
  }

  Future<void> deleteUniversidad(String id) async {
    await _collection.doc(id).delete();
  }

  Future<Universidad?> getUniversidadById(String id) async {
    final doc = await _collection.doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data() as Map<String, dynamic>;
    return Universidad.fromJson(data, doc.id);
  }
}
