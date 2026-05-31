import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fit_tracker/app/models/measurement_model.dart';
import 'package:fit_tracker/app/repositories/measurement_repository.dart';

class ProgressState {
  final List<Measurement> measurements;
  final bool isLoading;
  const ProgressState({
    this.measurements = const [],
    this.isLoading = false,
  });
  ProgressState copyWith({List<Measurement>? measurements, bool? isLoading}) {
    return ProgressState(
      measurements: measurements ?? this.measurements,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ProgressCubit extends Cubit<ProgressState> {
  final MeasurementRepository _measurementRepository;
  ProgressCubit(this._measurementRepository) : super(const ProgressState());
  void loadMeasurements() {
    final measurements = _measurementRepository.getMeasurements();
    emit(ProgressState(measurements: measurements));
  }

  Future<void> addMeasurement(Measurement measurement) async {
    await _measurementRepository.addMeasurement(measurement);
    loadMeasurements();
  }

  Future<void> deleteMeasurement(int displayIndex) async {
    final current = state.measurements;
    final actualIndex = current.length - 1 - displayIndex;
    await _measurementRepository.deleteMeasurement(actualIndex);
    loadMeasurements();
  }

  Future<void> clearMeasurements() async {
    await _measurementRepository.clearMeasurements();
    loadMeasurements();
  }
}

