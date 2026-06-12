import 'package:fit_tracker/data/model/measurement_model.dart';

abstract class MeasurementRepository {
  List<Measurement> getMeasurements(String username);
  Future<void> saveMeasurements(
      String username, List<Measurement> measurements);
  Future<void> addMeasurement(String username, Measurement measurement);
  Future<void> deleteMeasurement(String username, int index);
  Future<void> clearMeasurements(String username);
}
