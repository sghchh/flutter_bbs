
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

/// created by sgh, 2019-05-08
/// 用来作为全局主题的Model
/// 实现用户自定义主题
class ThemeModel extends Model {
  final theme = ThemeData(
    appBarTheme: AppBarTheme(),    // AppBar的背景色
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    textTheme: TextTheme(
      title: TextStyle(),  // 设置AppBar中文本风格
      body1: TextStyle()      // 设置帖子展示list的文本风格
    )
  );
}