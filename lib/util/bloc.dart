import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WidgetBuilderFactory<T> {
  BlocWidgetBuilder<T> builder() {
    return (BuildContext context, T state) => translate(state);
  }

  Widget translate(T state);
}
