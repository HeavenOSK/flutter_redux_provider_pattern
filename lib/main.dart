import 'package:flutter/material.dart';
import 'package:flutter_redux_provider_pattern/app.dart';
import 'package:flutter_redux_provider_pattern/redux/app_state.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

import 'redux/redux.dart';

void main() {
  runApp(
    /// Providerを使って、AppStateを保持するStoreを配置します。
    Provider(
      create: (context) => Store<AppState>(
        /// AppStateを更新するためのReducerを設定します。
        appReducer,

        /// AppStateの初期状態を設定します。
        initialState: AppState.initialize(),
        middleware: [
          /// counterの加算・減算処理を行うmiddlewareを配置します。
          /// リスト内で展開するために、[...]　記法を使用しています。
          ...counterMiddleware(),
        ],
      ),
      child: const App(),
    ),
  );
}
