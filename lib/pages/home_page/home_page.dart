import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  static Widget withDependencies(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_context) => Model(
        store: Provider.of(context),
      ),
      child: const HomePage(),
    );
  }

  static const routeName = 'home_page';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Domo of Reudx with Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'You have pushed the button this many times:',
            ),
            _CounterText(),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildFab(
            label: '+10',
            onTap: () => model.add(10),
          ),
          _buildFab(
            label: '+1',
            onTap: () => model.add(1),
          ),
          _buildFab(
            label: '-1',
            onTap: () => model.subtract(1),
          ),
          _buildFab(
            label: '-10',
            onTap: () => model.subtract(10),
          ),
        ],
      ),
    );
  }

  Widget _buildFab({@required String label, @required VoidCallback onTap}) {
    return FloatingActionButton(
      onPressed: onTap,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _CounterText extends StatelessWidget {
  const _CounterText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    return Text(
      '${model.counter}',
      style: Theme.of(context).textTheme.display1,
    );
  }
}
