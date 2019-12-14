import 'package:flutter/foundation.dart';
import 'package:flutter_redux_provider_pattern/redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:subscription_holder/subscription_holder.dart';

extension _CounterState on AppState {
  bool changedIn({
    int counter,
  }) {
    return this.counter != counter;
  }
}

class Model extends ChangeNotifier with SubscriptionHolderMixin {
  Model({
    @required this.store,
  })  : assert(store != null),
        counter = store.state.counter {
    subscriptionHolder.add(
      store.onChange.listen(
        (state) {
          if (state.changedIn(counter: counter)) {
            counter = state.counter;
            notifyListeners();
          }
        },
      ),
    );
  }

  final Store<AppState> store;
  int counter;

  void add(int value) => store.dispatch(CounterAddAction(value));

  void subtract(int value) => store.dispatch(CounterSubtractAction(value));
}
