
import 'package:flutter_bbs/pages/home/home_stateful.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;

import 'package:flutter/material.dart';

class HomePageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        HomeWidget(tap: const_util.NEWREPLY),
        HomeWidget(tap: const_util.NEWPUBLISH),
        HomeWidget(tap: const_util.TODATHOT)
      ]
    );
  }
}


