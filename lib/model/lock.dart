import 'package:universy/util/object.dart';

import 'copyable.dart';

class StateLock<T extends Copyable> {
  final T snapshot;

  const StateLock._(this.snapshot);

  bool hasChange(T newSnapshot) {
    return this.snapshot != newSnapshot;
  }

  factory StateLock.lock({T snapshot}) {
    if (notNull(snapshot)) {
      return StateLock._(snapshot.copy());
    }
    return StateLock._(null);
  }
}
