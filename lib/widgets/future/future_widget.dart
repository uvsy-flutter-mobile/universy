import 'package:flutter/material.dart';
import 'package:universy/util/object.dart';
import 'package:universy/widgets/progress/circular.dart';

class FutureWidget<T> extends StatelessWidget {
  final Future<T> _forFuture;
  final OnDataCallBack<T> _onData;
  final Widget _onMeanTime;
  final Widget _onError;

  FutureWidget({
    @required Future<T> fromFuture,
    @required OnDataCallBack<T> onData,
    Widget onMeanTime = const CenterSizedCircularProgressIndicator(),
    Widget onError,
  })  : this._forFuture = FutureWrap(fromFuture).get(),
        this._onData = onData,
        this._onMeanTime = onMeanTime,
        this._onError = onError;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _forFuture,
      builder: createBuilder(),
    );
  }

  AsyncWidgetBuilder<T> createBuilder() {
    return (BuildContext context, AsyncSnapshot snapshot) {
      if (snapshot.hasData) {
        if (snapshot.data != null) {
          return _onData(snapshot.data);
        }
      } else if (snapshot.hasError) {
        if (notNull(_onError)) {
          return _onError;
        }
      }
      return _onMeanTime;
    };
  }
}

class FutureWrap<T> {
  final Future<T> _future;

  FutureWrap(this._future);

  Future<T> get() async {
    try {
      return await _future;
    } catch (e) {
      return Future.error(e);
    }
  }
}

typedef OnDataCallBack<T> = Function(T data);
