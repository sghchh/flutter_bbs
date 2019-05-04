
import 'package:flutter/material.dart';

BuildContext _buildContext;

void init() {

}

void show(content) {
  Scaffold.of(_buildContext).showSnackBar(new SnackBar(content: content));
}

class SnapBarUtil {
  static BuildContext _buildContext;
  static SnapBarUtil _instance;
  SnapBarUtil();

  static void init(context) {
    _buildContext = context;
    _instance = SnapBarUtil();
  }

  static SnapBarUtil getInstance() => _instance;

  void show(content) {
    Scaffold.of(_buildContext).showSnackBar(SnackBar(content: Text(content), duration: Duration(milliseconds: 1500),));
  }

}