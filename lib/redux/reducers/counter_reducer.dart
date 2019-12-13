import 'package:flutter_redux_provider_pattern/redux/actions/counter_actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_types/redux_types.dart';

import '../app_state.dart';

/// counterの更新を担当するReducerです。Actionで受け取ったresultを使用して、
/// [AppState#counter]を更新しています。
///
/// 複数のReducerを束ねるために[combineReducers]メソッドを使用しています。
///
/// Reducerの型にAppStateクラスを指定しているのがポイントです。
/// [redux/reducers/app_reducer.dart]で詳しく述べていますが、すべて[AppState]を指定
/// することで、Reducerを簡単にまとめることができるようになります。
///
/// また、全てのReducerの型をAppStateを指定しておくことで「更新しやすいAppState」を設計する
/// 必要があります。
Reducer<AppState> counterReducer = combineReducers(
  [
    /// 加算結果を[CounterAddSucceededAction]で受け取りAppStateの[counter]プロパティを
    /// 更新します。
    ReducerOf<AppState, CounterAddSucceededAction>(
      callback: (state, action) {
        return state.copyWith(
          counter: action.result,
        );
      },
    ),

    /// 減産結果を[CounterSubtractSucceededAction]で受け取りAppStateの[counter]プロパティを
    /// 更新します。
    ReducerOf<AppState, CounterSubtractSucceededAction>(
      callback: (state, action) {
        return state.copyWith(
          counter: action.result,
        );
      },
    ),
  ],
);
