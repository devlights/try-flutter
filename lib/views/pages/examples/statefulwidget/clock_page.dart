import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// [StatefulWidget]を継承したウィジェット
///
/// [StatefulWidget]を継承した場合[createState]メソッドをオーバーライドする
/// 必要がある.このメソッドからは自身に対応する[State]オブジェクトを生成して返す.
class ClockPage extends StatefulWidget {
  const ClockPage({
    Key? key,
  }) : super(key: key);

  @override
  _ClockPageState createState() {
    return _ClockPageState();
  }
}

/// [ClockPage]に対応する[State]オブジェクト
///
/// このクラスで状態管理を行いながらUIを処理する.
///
/// 主に利用する親クラスのメソッドは以下
///
/// - initState
/// - dispose
/// - build
///
/// [setState]を呼び出すと、buildメソッドが呼び出される.
/// なので、UIを反映したくなったら[setState]を呼び出せば良い.
/// [setState]の引数にコールバックを渡すことができるので
/// この中でUI変更に関わる値を変更する.
///
class _ClockPageState extends State<ClockPage> {
  var dt = DateTime.now();

  late DateFormat _formatter;
  late Timer _timer;

  @override
  void initState() {
    _formatter = DateFormat("HH:mm:ss");

    // 1秒毎に着火するタイマーで setState を呼び出して UI を更新
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        // このコールバックの処理が終わると build メソッドが呼び出される
        dt = DateTime.now();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stateful Widget'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          _formatter.format(dt),
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}
