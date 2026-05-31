import 'package:flutter/foundation.dart';

/// Base class for all ViewModels in the application
/// Handles common state management and lifecycle
abstract class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

  @protected
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  @protected
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  @protected
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Execute async operation with loading state
  @protected
  Future<T> executeAsync<T>(Future<T> Function() operation) async {
    try {
      setLoading(true);
      clearError();
      final result = await operation();
      setLoading(false);
      return result;
    } catch (e) {
      setError(e.toString());
      setLoading(false);
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
