import 'package:flutter/foundation.dart';
import 'package:flutter_redux_provider_pattern/redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:subscription_holder/subscription_holder.dart';

/// extensionで[AppState]を拡張して、[changedIn]メソッドを実装しています。
/// [HomePage]に関連する値が変更されたかどうかをチェックします。今回の場合は
/// [counter]の値のみです。下記の[Model]内で使用します。
extension _CounterState on AppState {
  bool changedIn({
    int counter,
  }) {
    return this.counter != counter;
  }
}

/// [HomePage]の状態を管理します。[ChangeNotifier]を継承しており[notifyListeners]
/// メソッドを使用してView側（つまりWidget側）を更新します。
///
/// [notifyListeners]メソッドを使用するタイミングは以下の2パターンです。
/// 1.　Model内の状態が書き換わった時
/// 2. [Store]の[AppState]の状態のうち、[HomePage]に関連する値が書き変わった時
///
/// 上記を実現するために[Store]を[Model]のコンストラクタで渡しています。
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
