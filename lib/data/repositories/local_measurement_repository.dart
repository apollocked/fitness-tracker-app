import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/data/services/measurement_repository.dart';
import 'package:fit_tracker/data/services/hive_storage_service.dart';

class LocalMeasurementRepository implements MeasurementRepository {
  @override
  List<Measurement> getMeasurements(String username) {
    final stored = HiveStorageService.getMeasurements(username);
    return stored.map((map) => Measurement.fromMap(map)).toList();
  }

  @override
  Future<void> saveMeasurements(
      String username, List<Measurement> measurements) async {
    final maps = measurements.map((m) => m.toMap()).toList();
    await HiveStorageService.saveMeasurements(username, maps);
  }

  @override
  Future<void> addMeasurement(String username, Measurement measurement) async {
    final measurements = getMeasurements(username);
    measurements.add(measurement);
    await saveMeasurements(username, measurements);
  }

  @override
  Future<void> deleteMeasurement(String username, int index) async {
    final measurements = getMeasurements(username);
    if (index >= 0 && index < measurements.length) {
      measurements.removeAt(index);
      await saveMeasurements(username, measurements);
    }
  }

  @override
  Future<void> clearMeasurements(String username) async {
    await HiveStorageService.saveMeasurements(username, []);
  }
}
