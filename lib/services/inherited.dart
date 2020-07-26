import 'package:flutter/material.dart';

import 'factory.dart';
import 'manifest.dart';

class Services extends InheritedWidget implements ServiceFactory {
  final ServiceFactory _serviceFactory;

  const Services(
      {Key key, @required ServiceFactory factory, @required Widget child})
      : assert(factory != null),
        assert(child != null),
        this._serviceFactory = factory,
        super(key: key, child: child);

  static Services of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Services>();
  }

  @override
  bool updateShouldNotify(Services oldWidget) {
    return this.factory().runtimeType == this.factory().runtimeType;
  }

  ServiceFactory factory() {
    return _serviceFactory;
  }

  @override
  AccountService accountService() {
    return _serviceFactory.accountService();
  }

  @override
  List<Service> services() {
    return _serviceFactory.services();
  }
}
