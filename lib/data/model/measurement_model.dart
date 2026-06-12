class Measurement {
  final DateTime date;
  final double weight;

  Measurement({
    required this.date,
    required this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date.toIso8601String(),
      'weight': weight,
    };
  }

  factory Measurement.fromMap(Map<String, dynamic> map) {
    return Measurement(
      date: DateTime.parse(map['date']),
      weight: (map['weight'] as num).toDouble(),
    );
  }
}
