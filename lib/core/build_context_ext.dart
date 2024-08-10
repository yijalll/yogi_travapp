import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  double get deviceHeight => MediaQuery.of(this).size.height;

  double get deviceWidth => MediaQuery.of(this).size.width;
}

extension NavigatorExt on BuildContext {
  void pop<T extends Object>([T? result]) {
    Navigator.pop(this, result);
  }

  void popToRoot<T extends Object>() {
    Navigator.popUntil(this, (route) => route.isFirst);
  }

  Future<T?> push<T extends Object>(Widget widget, [String? name]) async {
    return Navigator.push<T>(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
        settings: RouteSettings(name: name),
      ),
    );
  }

  Future<T?> pushReplacement<T extends Object, TO extends Object>(
      Widget widget) async {
    return Navigator.pushReplacement<T, TO>(
      this,
      MaterialPageRoute(builder: (context) => widget),
    );
  }

  Future<T?> pushAndRemoveUntil<T extends Object>(
      Widget widget, bool Function(Route<dynamic> route) predicate) async {
    return Navigator.pushAndRemoveUntil<T>(
      this,
      MaterialPageRoute(builder: (context) => widget),
      predicate,
    );
  }
}

extension ScaffoldMessengerExtensions on BuildContext {
  void showDialogSuccess(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showDialogError(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
