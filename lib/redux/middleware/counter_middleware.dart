import 'package:flutter_redux_provider_pattern/redux/actions/counter_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_types/redux_types.dart';

import '../app_state.dart';

/// 現在の[AppState#counter]とActionで受け取った値をもとに、
/// 処理結果を算出してReducerに結果を伝達するためのmiddlewareです。
///
/// 今回の例では、「カウンタの加算・減算を行う」起因となるActionと、
/// 「カウンタの加算・減算結果」をReducerに伝えて更新させるためのActionに分けています。
///
/// 加算減算を行う単純なロジックではMiddlewareは用意せずReducerだけで更新を行うことも出来ます。
/// しかし、私の経験上、実際のアプリケーション開発ではMiddleware内でAPIを呼び出し、
/// その結果をAction経由でReducerで伝える、という処理フローをよく実装しますので、この処理フローを踏襲しています。
List<Middleware<AppState>> counterMiddleware() {
  return [
    /// 現在の[AppState#counter]に[CounterAddAction]で受け取ったvalueを足し合わせ、
    /// 計算結果を[CounterAddSucceededAction]を用いてReducerに伝えています。
    MiddlewareOf<AppState, CounterAddAction>(
      callback: (store, action, next) async {
        final newCounter = store.state.counter + action.value;
        next(CounterAddSucceededAction(newCounter));
      },
    ),

    /// 現在の[AppState#counter]から[CounterSubtractAction]で受け取ったvalueを差し引き、
    /// 計算結果を[CounterSubtractSucceededAction]を用いてReducerに伝えています。
    MiddlewareOf<AppState, CounterSubtractAction>(
      callback: (store, action, next) async {
        final newCounter = store.state.counter - action.value;
        next(CounterSubtractSucceededAction(newCounter));
      },
    ),
  ];
}
