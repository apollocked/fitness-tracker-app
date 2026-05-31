import 'package:fit_tracker/data/model/measurement_model.dart';

abstract class MeasurementRepository {
  List<Measurement> getMeasurements();
  Future<void> saveMeasurements(List<Measurement> measurements);
  Future<void> addMeasurement(Measurement measurement);
  Future<void> deleteMeasurement(int index);
  Future<void> clearMeasurements();
}

