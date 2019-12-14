import 'package:flutter/foundation.dart';
import 'package:flutter_redux_provider_pattern/redux/redux.dart';
import 'package:redux/redux.dart';

class HomePageModel {
  HomePageModel({
    @required this.store,
  }) : assert(store != null);

  final Store<AppState> store;

  void add(int value) => store.dispatch(CounterAddAction(value));

  void subtract(int value) => store.dispatch(CounterSubtractAction(value));
}
