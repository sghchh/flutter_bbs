import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/home/home_stateful.dart';

import 'package:flutter_bbs/utils/constant.dart' as ConstUtil;
class HomePageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: <Widget>[
        HomeWidget(tap: ConstUtil.NEWREPLY),
        HomeWidget(tap: ConstUtil.NEWPUBLISH),
        HomeWidget(tap: ConstUtil.TODATHOT)
      ]
    );
  }
}


