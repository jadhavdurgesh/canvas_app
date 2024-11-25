import 'package:firebase_database/firebase_database.dart';
import '../model/drawing_point.dart';

class FirebaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  /// Save a drawing point to Firebase
  Future<void> saveDrawingPoint(DrawingPoint point) async {
    await _db.child('canvas/${point.id}').set(point.toJson());
  }

  /// Fetch all drawing points from Firebase
  Future<List<DrawingPoint>> fetchDrawingPoints() async {
    final snapshot = await _db.child('canvas').get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      return data.values
          .map((point) =>
              DrawingPoint.fromJson(Map<String, dynamic>.from(point)))
          .toList();
    }
    return [];
  }

  /// Listen for real-time updates
  void listenForUpdates(Function(List<DrawingPoint>) onUpdate) {
    _db.child('canvas').onValue.listen((event) {
      if (event.snapshot.value != null) {
        final data = Map<String, dynamic>.from(event.snapshot.value as Map);
        final points = data.values
            .map((point) =>
                DrawingPoint.fromJson(Map<String, dynamic>.from(point)))
            .toList();
        onUpdate(points); // Trigger callback with updated points
      }
    });
  }
}
