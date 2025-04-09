// lib/core/util/uuid_provider.dart

import 'package:uuid/uuid.dart';

class UuidProvider {
  final Uuid _uuid = Uuid();

  String generate() {
    return _uuid.v4();
  }
}
