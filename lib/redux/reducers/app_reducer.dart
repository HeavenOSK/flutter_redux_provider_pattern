import 'package:redux/redux.dart';

import '../app_state.dart';
import 'counter_reducer.dart';

final Reducer<AppState> appReducer = combineReducers<AppState>(
  [
    counterReducer,
  ],
);
