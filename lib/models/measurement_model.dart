class Measurement {
  final DateTime date;
  final double weight;
  // REMOVED: final double? waist;

  Measurement({
    required this.date,
    required this.weight,
    // REMOVED: this.waist,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'weight': weight,
      // REMOVED: 'waist': waist,
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      date: DateTime.parse(map['date']),
      weight: map['weight'],
      // REMOVED: waist: map['waist'],
    );
  }
}

// Global list to store measurements
List<Measurement> measurements = [];
