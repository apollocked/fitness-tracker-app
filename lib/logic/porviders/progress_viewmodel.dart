import 'package:flutter/foundation.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/data/services/measurement_repository.dart';

class ProgressViewModel extends ChangeNotifier {
  final MeasurementRepository _measurementRepository;

  ProgressViewModel(this._measurementRepository) {
    loadMeasurements();
  }

  List<Measurement> _measurements = [];
  final bool _isLoading = false;

  List<Measurement> get measurements => _measurements;
  bool get isLoading => _isLoading;

  void loadMeasurements() {
    _measurements = _measurementRepository.getMeasurements();
    notifyListeners();
  }

  Future<void> addMeasurement(Measurement measurement) async {
    await _measurementRepository.addMeasurement(measurement);
    loadMeasurements();
  }

  Future<void> deleteMeasurement(int displayIndex) async {
    final current = _measurements;
    final actualIndex = current.length - 1 - displayIndex;
    await _measurementRepository.deleteMeasurement(actualIndex);
    loadMeasurements();
  }

  Future<void> clearMeasurements() async {
    await _measurementRepository.clearMeasurements();
    loadMeasurements();
  }
}
