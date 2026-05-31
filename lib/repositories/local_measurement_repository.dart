import 'package:myapp/models/measurement_model.dart';
import 'package:myapp/repositories/measurement_repository.dart';
import 'package:myapp/services/storage_service.dart';

class LocalMeasurementRepository implements MeasurementRepository {
  @override
  List<Measurement> getMeasurements() {
    final stored = StorageService.getMeasurements();
    return stored.map((map) => Measurement.fromMap(map)).toList();
  }

  @override
  Future<void> saveMeasurements(List<Measurement> measurements) async {
    final maps = measurements.map((m) => m.toMap()).toList();
    await StorageService.saveMeasurements(maps);
  }

  @override
  Future<void> addMeasurement(Measurement measurement) async {
    final measurements = getMeasurements();
    measurements.add(measurement);
    await saveMeasurements(measurements);
  }

  @override
  Future<void> deleteMeasurement(int index) async {
    final measurements = getMeasurements();
    if (index >= 0 && index < measurements.length) {
      measurements.removeAt(index);
      await saveMeasurements(measurements);
    }
  }

  @override
  Future<void> clearMeasurements() async {
    await StorageService.saveMeasurements([]);
  }
}
