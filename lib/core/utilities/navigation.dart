import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

navigateTo(widget, {bool withHistory = true}) {
  Navigator.pushAndRemoveUntil(navigatorKey.currentContext!,
      MaterialPageRoute(builder: (c) {
    return widget;
  }), (route) => withHistory);
}
