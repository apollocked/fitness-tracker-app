import 'package:myapp/services/storage_service.dart';

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
      weight: map['weight'],
    );
  }
}

// Load measurements from storage
List<Measurement> getMeasurements() {
  final stored = StorageService.getMeasurements();
  return stored.map((map) => Measurement.fromMap(map)).toList();
}

// Save measurements to storage
Future<void> saveMeasurements(List<Measurement> measurements) async {
  final maps = measurements.map((m) => m.toMap()).toList();
  await StorageService.saveMeasurements(maps);
}

// Add a measurement
Future<void> addMeasurement(Measurement measurement) async {
  final measurements = getMeasurements();
  measurements.add(measurement);
  await saveMeasurements(measurements);
}

// Delete a measurement
Future<void> deleteMeasurement(int index) async {
  final measurements = getMeasurements();
  if (index >= 0 && index < measurements.length) {
    measurements.removeAt(index);
    await saveMeasurements(measurements);
  }
}

// Clear all measurements
Future<void> clearMeasurements() async {
  await StorageService.saveMeasurements([]);
}
