import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/home/home_stateful.dart';

class HomePageWidget extends StatelessWidget {

  List<Widget> content;
  HomePageWidget({this.content});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: content
    );
  }
}


