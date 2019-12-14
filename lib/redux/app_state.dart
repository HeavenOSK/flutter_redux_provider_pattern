class AppState {
  const AppState._({
    this.counter,
  });

  factory AppState.initialize() {
    return const AppState._(
      counter: 0,
    );
  }

  final int counter;

  AppState copyWith({
    int counter,
  }) {
    return AppState._(
      counter: counter ?? this.counter,
    );
  }

  @override
  String toString() => 'AppState{'
      'counter:$counter'
      '}';
}
