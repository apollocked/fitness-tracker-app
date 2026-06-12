import 'package:flutter/foundation.dart';
import 'package:fit_tracker/data/model/measurement_model.dart';
import 'package:fit_tracker/data/services/measurement_repository.dart';
import 'package:fit_tracker/data/repositories/auth_repository.dart';

class ProgressViewModel extends ChangeNotifier {
  final MeasurementRepository _measurementRepository;
  final AuthRepository _authRepository;

  ProgressViewModel(this._measurementRepository, this._authRepository);

  List<Measurement> get measurements =>
      _measurementRepository.getMeasurements(_currentUsername);

  String get _currentUsername =>
      _authRepository.getCurrentUser()?.username ?? '';

  Future<void> loadMeasurements() async {
    notifyListeners();
  }

  Future<void> addMeasurement(Measurement measurement) async {
    await _measurementRepository.addMeasurement(_currentUsername, measurement);
    notifyListeners();
  }

  Future<void> deleteMeasurement(int index) async {
    await _measurementRepository.deleteMeasurement(_currentUsername, index);
    notifyListeners();
  }
}
