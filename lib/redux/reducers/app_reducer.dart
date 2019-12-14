import 'package:redux/redux.dart';

import '../app_state.dart';
import 'counter_reducer.dart';

/// combineReducersを用いて複数のReducerを束ねて１つのReducerにします。
///
/// 同じStateを更新するReducerであれば、何層になってcombineReducersで対応できますので、
/// すべてのReducerを同じState型を指定するようにします。
///
/// # 例
/// final Reducer<AppState> appReducer = combineReducers<AppState>(
///   [
///     reducerA,
///     reducerB
///   ],
/// );
///
///
/// final Reducer<AppState> reducerA = combineReducers<AppState>(
///   [
///     counterReducer01,
///     counterReducer02,
///   ],
/// );
///
/// final Reducer<AppState> reducerB = combineReducers<AppState>(
///   [
///     counterReducer03,
///     counterReducer04,
///   ],
/// );
///
final Reducer<AppState> appReducer = combineReducers<AppState>(
  [
    counterReducer,
  ],
);
