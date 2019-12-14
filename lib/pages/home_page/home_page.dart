import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter_text/counter_text.dart';
import 'model.dart';

class HomePage extends StatelessWidget {
  const HomePage._({Key key}) : super(key: key);

  static Widget withDependencies(BuildContext context) {
    return Provider(
      create: (_context) => HomePageModel(
        store: Provider.of(context),
      ),
      child: const HomePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomePageModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo of Reudx with Provider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            CounterText.withDependencies(context),
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
