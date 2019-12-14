import 'package:flutter/material.dart';
import 'package:flutter_redux_provider_pattern/app.dart';
import 'package:flutter_redux_provider_pattern/redux/app_state.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

import 'redux/redux.dart';

void main() {
  runApp(
    Provider(
      create: (context) => Store<AppState>(
        appReducer,
        initialState: AppState.initialize(),
        middleware: [
          ...counterMiddleware(),
        ],
      ),
      child: const App(),
    ),
  );
}
