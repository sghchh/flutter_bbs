import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/board/child_board/board_child.dart';
import 'package:flutter_bbs/pages/board/child_board/board_child_stateful.dart';
import 'package:flutter_bbs/utils/constant.dart' as const_util;

///created by sgh     2019-3-1
/// 用来将板块列表的数据转化成Widget
class MapUtil {

  BuildContext context;
  List _sourceData;           //从后台获取的板块列表的源数据
  final List<Widget> finalResult = <Widget>[];    //最后返回的Widget的List，用来给Board页面构建布局

  MapUtil(sourceData, context):this._sourceData = sourceData, this.context = context {
    _mapToWidgetList();
  }

  _mapToWidgetList() {
    for(int i = 0; i < _sourceData.length; i++) {
      // 如果该板块关闭，直接跳过
      if(const_util.forbiddenBoard[_sourceData[i].board_category_name] == 1)
        continue;
      var categoryItem = _mapCategory(_sourceData[i]);
      for (int j = 0; j < categoryItem.length; j++) {
        finalResult.add(categoryItem[j]);
      }
    }
  }

  //负责将每一个Category分类及其下面的板块构建成Widget
  _mapCategory(sourceData) {
    var categoryId = sourceData.board_category_name;        //获取板块分类的名称
    List<Widget> results = <Widget>[];
    var name = SliverPersistentHeader(
      delegate: SliverAppBarDelegate(minHeight: 20, maxHeight: 25, child: Container(
        padding: EdgeInsets.only(left: 20, top: 1, bottom: 1),
        child: Text("${categoryId}", textScaleFactor: 1.2, style: TextStyle(color: Colors.grey),),
      ),),
    );
    results.add(name);
    List boardList = sourceData.board_list;
    // 取出关闭的板块
    for ( int i = 0; i < boardList.length; ) {
      if (const_util.forbiddenBoard[boardList[i].board_name] == 1) {
        boardList.removeAt(i);
        continue;
      }
      i++;
    }
    results.add(_mapCardBoard(boardList));
    return results;
  }

  // 构建Card的板块，参数为List<_BoardList>
  _mapCardBoard(sourceBoardData) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return _buildItem(sourceBoardData[index]);
        },
        childCount: sourceBoardData.length,
      ),
    );
  }

// 构建card布局,参数为_BoardList
  Widget _buildItem(data) {
    return Card(
      child: Container(
        //padding: EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ChildBoardInfoWidget(data.board_id, data.board_name);
                //return BoardPostWidget('', 316);
              }));
            },
            child: Column(
              children: <Widget>[
                Align(
                  child: Container(
                    padding: EdgeInsets.only(top: 5),
                    child: Image.network(data.board_img, height: 60, width: 60,),
                  ),
                  alignment: Alignment.topCenter,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 2, bottom: 2),
                    child: Text("${data.board_name}" , style: TextStyle( fontSize: 10)),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}




///用来构建Board界面中“分类”的Text条目
class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}