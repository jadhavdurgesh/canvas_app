import 'package:firebase_database/firebase_database.dart';
import '../model/drawing_point.dart';

class FirebaseService {
  final DatabaseReference _db = FirebaseDatabase.instance.ref();

  Future<void> saveDrawingPoint(DrawingPoint point) async {
    final jsonData = point.toJson();
    print(jsonData); // Debug the data
    await _db.child('canvas/${point.id}').set(jsonData);
  }

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

  void listenForUpdates(Function(List<DrawingPoint>) onUpdate) {
    _db.child('canvas').onValue.listen((event) {
      print("Database update received: ${event.snapshot.value}");
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
