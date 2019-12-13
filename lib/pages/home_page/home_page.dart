import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

/// このexampleの唯一の画面です。
/// Flutterのプロジェクト作成時に自動生成されるカウンタ画面を少し改変したものです。
class HomePage extends StatelessWidget {
  /// [HomePage]のコンストラクタは[_]としてローカルメソッドにしています。
  /// [HomePage]を生成する際には下記の[withDependencies]を使用します。
  const HomePage._({Key key}) : super(key: key);

  /// [HomePage]を画面を、状態を管理する[ChangeNotifier], そのModelを保持するための
  /// [ChangeNotifierProvider] をセットで生成する際の記法です。
  ///
  /// ビジネスロジックを[ChangeNotifier]を継承した[Model]に切り出す事で可読性・メンテナンス性が向上します。
  /// Reduxを併用する場合は、以下のように引数で[context]を注入して[Provider]を使って、[Model]に
  /// [Store]を渡しています。
  ///
  /// この記法は[mono0926](https://github.com/mono0926)さんの記法を影響を受けたものです。
  /// その他の例を見たい方は, mono0926さんの[google-tasks-clone](google-tasks-clone)
  /// を参考にするとよいと思います。
  static Widget withDependencies(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_context) => Model(
        /// [Store]をモデルに渡しています。
        /// Providerの createメソッド内では[XXXX.of]メソッドを使用できないので、
        /// [_context]ではなく[withDependencies]で受け取った[context]が使用しています。
        store: Provider.of(context),
      ),
      child: const HomePage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
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
            Text(
              '${model.counter}',
              style: Theme.of(context).textTheme.display1,
            ),
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
