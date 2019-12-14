import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_text_model.dart';

class CounterText extends StatelessWidget {
  const CounterText._({Key key}) : super(key: key);

  static Widget withDependencies(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_context) => CounterTextModel(
        store: Provider.of(context),
      ),
      child: const CounterText._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<CounterTextModel>(context);
    return Text(
      '${model.counter}',
      style: Theme.of(context).textTheme.display1,
    );
  }
}
