import 'package:flutter_bbs/network/json/bbs_response.dart';

/// Board界面获取板块列表的Json
class ForumListModel {
  List<_Data> list;    // 每一个item代表一个Category
  Head head;   // 封装错误信息

  ForumListModel.fromJson(Map<String, dynamic> json)
      : this.head = Head.fromJson(json['head']){

    var results = <_Data>[];
    for(int i = 0; i < json['list'].length; i++) {
      var item = _Data.fromJson(json['list'][i]);
      results.add(item);
    }
    this.list = results;
  }
}

/// ForumListModel的内部元素
/// 代表一个Category，如：成电校园等此类
class _Data {
  List<_BoardList> board_list;  // 每一个item代表板块，如：校园热点、就业创业
  int board_category_id;    // 所属Category的id
  String board_category_name;     // 所属Category的name

  _Data.fromJson(Map<String, dynamic> json)
      : this.board_category_id = json['board_category_id'],
        this.board_category_name = json['board_category_name']{

    var _item = <_BoardList>[];
    for (int i = 0; i < json['board_list'].length; i++) {
      var item0 = _BoardList.fromJson(json['board_list'][i]);
      _item.add(item0);
    }
    this.board_list = _item;
  }
}

/// _Data的内部元素
/// 代表“就业创业”这种每个板块的信息
class _BoardList {
  int board_id;    // 板块的id
  String board_name;  // 板块的名字，如：就业创业
  String board_img;     // 代表板块的图片的URL
  String last_posts_date;      // 代表板块中最后一个评论的时间

  _BoardList.fromJson(Map<String, dynamic> json)
      : this.board_id = json['board_id'],
        this.board_name = json['board_name'],
        this.board_img = json['board_img'],
        this.last_posts_date = json ['last_posts_date'];
}

/// 该类是点击板块列表中的板块的时候
/// 每个板块及其下面的主题的信息，如：就业创业 下的 招聘信息发布栏
/// 该类封装在BBSResponse下
class Board {
  int board_category_id;     // 对应的板块的id
  String board_category_name;     // 对应板块的名字，如：就业创业
  List<ChildBoard> board_list;     // 每一个item代表一个主题，如：招聘信息发布栏

  Board.fromJson(Map<String, dynamic> json)
      : this.board_category_id = json['board_category_id'],
        this.board_category_name = json['board_category_name'] {

    var result = <ChildBoard>[];
    for (int i = 0; i < json['board_list'].length; i ++) {
      var item = ChildBoard.fromJson(json['board_list'][i]);
      result.add(item);
    }
    this.board_list = result;
  }
}

/// 主题的信息
class ChildBoard {
  int board_id;     // 主题的id，在获取某一主题下的发帖时需要传递该参数
  String board_name;   // 主题的名字

  ChildBoard.fromJson(Map<String, dynamic> json)
      : this.board_id = json['board_id'],
        this.board_name = json['board_name'];
}
