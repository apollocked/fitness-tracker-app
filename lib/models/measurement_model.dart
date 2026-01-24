class Measurement {
  final DateTime date;
  final double? weight;
  final double? chest;
  final double? waist;
  final double? hips;
  final double? arms;
  final double? thighs;

  Measurement({
    required this.date,
    this.weight,
    this.chest,
    this.waist,
    this.hips,
    this.arms,
    this.thighs,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'weight': weight,
      'chest': chest,
      'waist': waist,
      'hips': hips,
      'arms': arms,
      'thighs': thighs,
    };
  }

  // Create from JSON
  factory Measurement.fromJson(Map<String, dynamic> json) {
    return Measurement(
      date: DateTime.parse(json['date']),
      weight: json['weight']?.toDouble(),
      chest: json['chest']?.toDouble(),
      waist: json['waist']?.toDouble(),
      hips: json['hips']?.toDouble(),
      arms: json['arms']?.toDouble(),
      thighs: json['thighs']?.toDouble(),
    );
  }
}
