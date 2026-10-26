import 'package:flutter/foundation.dart';

void p(String pesan) {
  const aktif = true;
  if (aktif && kDebugMode) {
    print(pesan);
  }
}
