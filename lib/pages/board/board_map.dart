import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

///created by sgh     2019-3-1
/// 用来将板块列表的数据转化成Widget
class MapUtil {

  List _sourceData;           //从后台获取的板块列表的源数据
  final List<Widget> finalResult = <Widget>[];    //最后返回的Widget的List，用来给Board页面构建布局

  MapUtil(sourceData):this._sourceData = sourceData {
    _mapToWidgetList();
  }

  _mapToWidgetList() {
    for(int i = 0; i < _sourceData.length; i++) {
      var categoryItem = _mapCategory(_sourceData[i]);
      for (int j = 0; j < categoryItem.length; j++) {
        finalResult.add(categoryItem[j]);
      }
    }
    return finalResult;
  }

  //负责将每一个板块分类及其下面的板块构建成Widget
  _mapCategory(sourceData) {
    var categoryId = sourceData.board_category_name;        //获取板块分类的名称
    List<Widget> results = <Widget>[];
    var name = SliverPersistentHeader(
      delegate: SliverAppBarDelegate(minHeight: 20, maxHeight: 40, child: Container(
        padding: EdgeInsets.only(left: 12, top: 1, bottom: 1),
        child: Text("${categoryId}", textScaleFactor: 1.4, style: TextStyle(color: Colors.grey),),
      ),),
    );
    results.add(name);
    results.add(_mapCardBoard(sourceData.board_list));
    return results;
  }

  //负责将每一个板块构建成Widget
  _mapBoard(sourceBoardData) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 5/2),
      delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              height: 50,
              decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 2.0)),
              padding: EdgeInsets.all(8),
              //margin: EdgeInsets.all(2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Image.network("${sourceBoardData[index].board_img}", height: 70, width: 70,),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 8, left: 6),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("${sourceBoardData[index].board_name}" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 8),
                          child: Align(
                            child: Text("${sourceBoardData[index].last_posts_date}" , style: TextStyle(color: Colors.grey, fontSize: 12)),
                            alignment: Alignment.centerLeft,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        childCount: sourceBoardData.length
      ),
    );
  }
}

// 构建Card的板块
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

// 构建card布局
Widget _buildItem(data) {
  return Container(
    //padding: EdgeInsets.all(8),
    child: Card(
      child: Column(
        children: <Widget>[
          Align(
            child: Container(
              padding: EdgeInsets.only(top: 5),
              child: CachedNetworkImage(imageUrl: data.board_img, height: 55, width: 55,),
            ),
            alignment: Alignment.topCenter,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(top: 2, bottom: 2),
              child: Text("${data.board_name}" , style: TextStyle( fontSize: 12)),
            ),
          )
        ],
      ),
    ),
  );
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