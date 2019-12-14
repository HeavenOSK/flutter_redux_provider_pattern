import 'package:flutter/foundation.dart';
import 'package:flutter_redux_provider_pattern/redux/redux.dart';
import 'package:redux/redux.dart';
import 'package:subscription_holder/subscription_holder.dart';

/// extensionで[AppState]を拡張して、[changedIn]メソッドを実装しています。
/// HomePageに関連する値が変更されたかどうかをチェックします。今回の場合は
/// [counter]の値のみです。下記の[Model]内で使用します。
extension _CounterState on AppState {
  bool changedIn({
    int counter,
  }) {
    return this.counter != counter;
  }
}

/// HomePageの状態を管理します。[ChangeNotifier]を継承しており[notifyListeners]
/// メソッドを呼び出し、ChangeNotifierProvider以下のWidgetを更新します。
///
/// Reduxで[ChangeNotifier]を使用する場合には以下のように、[Model]のコンストラクタで
/// [Store<AppState>]を渡すのが良いと思います。
///
/// こうすることで、以下の事が実現できます。
/// 1. [Model]上でdispatchメソッドを呼ぶことができる
/// 2. [Model]上でHomePageのローカルステートと、[Store]が保持している[AppState]の
/// 　どちらも利用することができる。
class Model extends ChangeNotifier with SubscriptionHolderMixin {
  Model({
    @required this.store,
  })  : assert(store != null),
        counter = store.state.counter {
    /// [Model]のコンストラクタで受け取った[Store]の[onChange]というStreamを
    /// listenしています。
    ///
    /// ここでは[SubscriptionHolderMixin]の[subscriptionHolder]に[listen]メソッドの
    /// 返り値のsubscriptionを渡しています。
    ///
    /// 非常に便利なmixinで、[subscriptionHolder]に追加したsubscriptionは
    /// [ChangeNotifier]のdispose時にcancelしてくれます。
    subscriptionHolder.add(
      /// [store]の[onChange]というStreamをlistenしています。[onChange]は[Store]の保持
      /// する[state]が変更される時に同期的に変更が反映されるStreamです。
      /// [onChange]を監視しておき、[AppState]が更新された際には[notifyListeners()]メソッドを
      /// 呼び出してWidgetを更新します。
      ///
      /// ここでは、上で定義した[_CounterState] extensionの[changedIn]メソッドを用いて、
      /// [AppState]の[counter]の値が更新されたかどうかをチェックしています。
      ///
      /// このように記述しておけば、[AppState]上の[counter]以外のフィールドが更新されたとしても、
      /// [counter]の値に変化がなければ[notifyListeners]が呼び出されることはありません。
      store.onChange.listen(
        (state) {
          if (state.changedIn(counter: counter)) {
            /// 変更があれば新しい値を代入して、[notifyListeners]で更新する。
            counter = state.counter;
            notifyListeners();
          }
        },
      ),
    );
  }

  final Store<AppState> store;
  int counter;

  /// [value]引数で受け取った値を使用して[CounterAddAction]をdispatchしています。
  void add(int value) => store.dispatch(CounterAddAction(value));

  /// [value]引数で受け取った値を使用して[CounterSubtractAction]をdispatchしています。
  void subtract(int value) => store.dispatch(CounterSubtractAction(value));
}
