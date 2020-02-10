import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model.dart';

/// このexampleの唯一の画面です。
/// Flutterのプロジェクト作成時に自動生成されるカウンタ画面を改造して、
/// 「+10」「+1」「-1」「-10」の4つの計算ができるようにしています。
class HomePage extends StatelessWidget {
  /// [HomePage]のコンストラクタはローカルメソッドとして定義しています。
  /// [HomePage]を生成する際には下記の[withDependencies]を使用します。
  const HomePage._({Key key}) : super(key: key);

  /// [HomePage]を画面を、状態を管理する[ChangeNotifier]を保持する[ChangeNotifierProvider]
  /// と一緒に生成する際の記法です。
  ///
  /// ビジネスロジックを[ChangeNotifier]を継承した[Model]に切り出す事で可読性・メンテナンス性が向上します。
  /// Reduxを併用する場合は[withDependencies]の引数で[context]を渡して、[Provider.of]メソッドで
  /// [Store<AppState>]を取得しています。
  ///
  /// この記法は[mono0926](https://github.com/mono0926)さんの記法を影響を受けたものです。
  /// その他の例を見たい方は, mono0926さんの[google-tasks-clone](https://github.com/mono0926/google-tasks-clone)
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
    /// [ChangeNotifier]に設定した[Model]を取得します。
    final model = Provider.of<Model>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo of Reudx with Provider'),
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

            /// [Model#add]を呼び出しています。
            onTap: () => model.add(10),
          ),
          _buildFab(
            label: '+1',

            /// [Model#add]を呼び出しています。
            onTap: () => model.add(1),
          ),
          _buildFab(
            label: '-1',

            /// [Model#subtract]を呼び出しています。
            onTap: () => model.subtract(1),
          ),
          _buildFab(
            label: '-10',

            /// [Model#subtract]を呼び出しています。
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

/// [Model#counter]の値を取得して表示しています。
///
/// 更新したい箇所だけ別Widgetに切り出し、内部で[Model]を取得するように
/// する、というのが[ChangeNotifier] & [ChangeNotifierProvider] を
/// 使用する際の定石です。
///
/// こうすることで、[Model.counter]が更新され[Model]が[ChangeNotifier.notifyListeners]を
/// 呼び出した際には、以下の切り出したWidgetだけに更新がかかるようになります。
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
