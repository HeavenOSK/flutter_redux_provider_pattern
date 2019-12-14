import 'package:flutter_redux_provider_pattern/redux/actions/counter_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_types/redux_types.dart';

import '../app_state.dart';

List<Middleware<AppState>> counterMiddleware() {
  return [
    MiddlewareOf<AppState, CounterAddAction>(
      callback: (store, action, next) async {
        final newCounter = store.state.counter + action.value;
        next(CounterAddSucceededAction(newCounter));
      },
    ),
    MiddlewareOf<AppState, CounterSubtractAction>(
      callback: (store, action, next) async {
        final newCounter = store.state.counter - action.value;
        next(CounterSubtractSucceededAction(newCounter));
      },
    ),
  ];
}
