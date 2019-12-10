import 'package:flutter/material.dart';
import 'package:flutter_redux_provider_pattern/pages/home_page/home_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter redux provider pattern',
      home: HomePage.withDependencies(context),
    );
  }
}
