import 'package:universy/util/object.dart';

import 'copyable.dart';

class SaveLock<T extends Copyable> {
  final T snapshot;

  const SaveLock._(this.snapshot);

  bool shouldSave(T newSnapshot) {
    return this.snapshot != newSnapshot;
  }

  factory SaveLock.lock({T snapshot}) {
    if (notNull(snapshot)) {
      return SaveLock._(snapshot.copy());
    }
    return SaveLock._(null);
  }
}
