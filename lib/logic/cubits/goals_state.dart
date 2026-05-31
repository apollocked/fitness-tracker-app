class GoalsState {
  final Map<String, Map<String, dynamic>> goals;
  final bool isLoading;
  const GoalsState({this.goals = const {}, this.isLoading = false});
  GoalsState copyWith(
      {Map<String, Map<String, dynamic>>? goals, bool? isLoading}) {
    return GoalsState(
      goals: goals ?? this.goals,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
