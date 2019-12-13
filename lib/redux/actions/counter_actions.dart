/// [AppState#counter]に対して加算処理を行うためのActionです。
///
/// [CounterAddAction]の[value]で指定した数値が[AppState#counter]に足し合わせられます。
class CounterAddAction {
  CounterAddAction(this.value);

  final int value;
}

/// 加算処理の結果で[AppState#counter]を更新するためのActionです。
class CounterAddSucceededAction {
  CounterAddSucceededAction(this.result);

  final int result;
}

/// [AppState#counter]に対して減算処理を行うためのActionです。
///
/// [CounterAddAction]の[value]で指定した数値が[AppState#counter]から差し引かれます。
class CounterSubtractAction {
  CounterSubtractAction(this.value);

  final int value;
}

/// 減算処理の結果で[AppState#counter]を更新するためのActionです。
class CounterSubtractSucceededAction {
  CounterSubtractSucceededAction(this.result);

  final int result;
}
