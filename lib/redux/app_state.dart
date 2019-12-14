import 'package:flutter/foundation.dart';

/// Reduxで扱う状態のクラスです。ReduxではAppStateと名付けるのが通例です。
/// Reduxでは一度インタンス化した[AppState]を改変しないため、@immutableアノテーションをつけています。
///
/// Storeが保持する状態を更新したい時は、[copyWith]メソッドを用いて新たな[AppState]インスタンスを作成して、
/// 古い[AppState]を置き換えます。
@immutable
class AppState {
  /// [AppState]のコンストラクタは、[_](アンダーバー)で宣言しています。
  /// これはAppState以外のクラスでも使えるTipsですが、このように宣言しておくとコンストラクタがローカルメソッドになります。
  /// こうすることで、外部で[AppState]をインスタンス化する方法を[AppState.initialize()]と[copyWith]
  /// に限定することができます。
  const AppState._({
    this.counter,
  });

  /// 初期状態の[AppState]を生成するファクトリーメソッドです。
  factory AppState.initialize() {
    return const AppState._(
      counter: 0,
    );
  }

  /// カウンターの値を保持します。
  final int counter;

  /// AppStateの更新にはこのメソッドを使用します。
  AppState copyWith({
    int counter,
  }) {
    return AppState._(
      counter: counter ?? this.counter,
    );
  }

  @override
  String toString() => 'AppState{'
      'counter:$counter'
      '}';
}
