import 'package:flutter/material.dart';

// class DrawingPoint {
//   int id;
//   List<Offset> offsets;
//   Color color;
//   double width;

//   DrawingPoint({
//     this.id = -1,
//     this.offsets = const [],
//     this.color = Colors.black,
//     this.width = 2,
//   });

//   DrawingPoint copyWith({List<Offset>? offsets}) {
//     return DrawingPoint(
//       id: id,
//       color: color,
//       width: width,
//       offsets: offsets ?? this.offsets,
//     );
//   }
// }

class DrawingPoint {
  int id;
  List<Offset> offsets;
  Color color;
  double width;

  DrawingPoint({
    this.id = -1,
    this.offsets = const [],
    this.color = Colors.black,
    this.width = 2,
  });

  DrawingPoint copyWith({List<Offset>? offsets}) {
    return DrawingPoint(
      id: id,
      color: color,
      width: width,
      offsets: offsets ?? this.offsets,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'offsets': offsets.map((e) => {'dx': e.dx, 'dy': e.dy}).toList(),
      'color': color.value, // Store color as int
      'width': width,
    };
  }

  // Convert from JSON
  factory DrawingPoint.fromJson(Map<String, dynamic> json) {
    return DrawingPoint(
      id: json['id'] ?? -1,
      offsets: (json['offsets'] as List)
          .map((e) => Offset(e['dx'], e['dy']))
          .toList(),
      color: Color(json['color'] ?? Colors.black.value),
      width: (json['width'] as num).toDouble(),
    );
  }
}
