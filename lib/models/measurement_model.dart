class Measurement {
  final DateTime date;
  final double? weight;
  final double? waist;

  Measurement({
    required this.date,
    this.weight,
    this.waist,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'weight': weight,
      'waist': waist,
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      date: DateTime.parse(map['date']),
      weight: map['weight'],
      waist: map['waist'],
    );
  }
}

// Global list to store measurements
List<Measurement> measurements = [];
