
import 'package:flutter_bbs/pages/home/home_stateful.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;

import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {

  TabController controller;
  HomePageWidget({this.controller});
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      children: <Widget>[
        HomeWidget(tap: const_util.TODATHOT),
        HomeWidget(tap: const_util.NEWREPLY),
        HomeWidget(tap: const_util.NEWPUBLISH),
      ]
    );
  }
}


