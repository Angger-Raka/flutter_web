import 'package:flutter/material.dart';

extension NumX on num {
  BorderRadius br() {
    return BorderRadius.circular(toDouble());
  }

  Radius r() {
    return Radius.circular(toDouble());
  }

  SizedBox sbh() {
    return SizedBox(height: toDouble());
  }

  SizedBox sbw() {
    return SizedBox(width: toDouble());
  }
}
