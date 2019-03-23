import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bbs/network/http_client.dart';
import 'package:flutter_bbs/network/json/bbs_response.dart';
import 'package:flutter_bbs/network/json/post.dart';

///created by sgh    2019-2-23
/// 编辑帖子界面选择板块的item
var typeItem = <String>['成电校园','科技交流','休闲娱乐','跳蚤市场','站务管理'];    //类型的list
var schoolItem = <String, int>{'就业创业' : 174,'情感专区': 45,'成电锐评' : 309,'校园热点' : 236,'交通出行' : 225,'成电轨迹' : 109,'同城同乡' : 17,'毕业感言' : 237};
var technologyItem = <String, int>{'前端之美' : 258,'数字前端' : 272,'电脑FAQ' : 66,'硬件数码' : 108,'Unix/Linux' : 99,'程序员' : 70,'电子设计' : 121};
var funItem = <String, int>{'水手之家' : 25,'吃喝玩乐' : 370,'成电骑迹' : 244,'视觉艺术' : 55,'军事国防' : 115,'情系舞缘' : 334,'音乐空间' : 74,'文人墨客' : 114,'体坛风云' : 118,'影视天地' : 149,'动漫时代': 140,'跑步公园' : 312};
var marketItem = <String, int>{'二手专区' : 61,'房屋租赁' : 255,'店铺专区' : 111};

var typeMenuItem = <DropdownMenuItem<String>>[
  DropdownMenuItem<String>(child: Text(typeItem[0], style: TextStyle(fontSize: 10),), value: typeItem[0]),
  DropdownMenuItem<String>(child: Text(typeItem[1], style: TextStyle(fontSize: 10),), value: typeItem[1]),
  DropdownMenuItem<String>(child: Text(typeItem[2], style: TextStyle(fontSize: 10),), value: typeItem[2]),
  DropdownMenuItem<String>(child: Text(typeItem[3], style: TextStyle(fontSize: 10),), value: typeItem[3]),
  //DropdownMenuItem<String>(child: Text(typeItem[4]), value: typeItem[4])
];

var schoolMenuItem = <DropdownMenuItem<int>>[
  DropdownMenuItem<int>(child: Text(schoolItem.keys.elementAt(0), style: TextStyle(fontSize: 10),), value: schoolItem.values.elementAt(0)),
  DropdownMenuItem<int>(child: Text(schoolItem.keys.elementAt(1), style: TextStyle(fontSize: 10),), value: schoolItem.values.elementAt(1)),
  DropdownMenuItem<int>(child: Text(schoolItem.keys.elementAt(2), style: TextStyle(fontSize: 10),), value: schoolItem.values.elementAt(2)),
  DropdownMenuItem<int>(child: Text(schoolItem.keys.elementAt(3), style: TextStyle(fontSize: 10),), value: schoolItem.values.elementAt(3)),
  DropdownMenuItem<int>(child: Text(schoolItem.keys.elementAt(4), style: TextStyle(fontSize: 10),), value: schoolItem.values.elementAt(4)),
  DropdownMenuItem<int>(child: Text(schoolItem.keys.elementAt(5), style: TextStyle(fontSize: 10),), value: schoolItem.values.elementAt(5)),
  DropdownMenuItem<int>(child: Text(schoolItem.keys.elementAt(6), style: TextStyle(fontSize: 10),), value: schoolItem.values.elementAt(6)),
  DropdownMenuItem<int>(child: Text(schoolItem.keys.elementAt(7), style: TextStyle(fontSize: 10),), value: schoolItem.values.elementAt(7)),
];

var technologyMenuItem = <DropdownMenuItem<int>>[
  DropdownMenuItem<int>(child: Text(technologyItem.keys.elementAt(0), style: TextStyle(fontSize: 10),), value: technologyItem.values.elementAt(0)),
  DropdownMenuItem<int>(child: Text(technologyItem.keys.elementAt(1), style: TextStyle(fontSize: 10),), value: technologyItem.values.elementAt(1)),
  DropdownMenuItem<int>(child: Text(technologyItem.keys.elementAt(2), style: TextStyle(fontSize: 10),), value: technologyItem.values.elementAt(2)),
  DropdownMenuItem<int>(child: Text(technologyItem.keys.elementAt(3), style: TextStyle(fontSize: 10),), value: technologyItem.values.elementAt(3)),
  DropdownMenuItem<int>(child: Text(technologyItem.keys.elementAt(4), style: TextStyle(fontSize: 10),), value: technologyItem.values.elementAt(4)),
  DropdownMenuItem<int>(child: Text(technologyItem.keys.elementAt(5), style: TextStyle(fontSize: 10),), value: technologyItem.values.elementAt(5)),
  DropdownMenuItem<int>(child: Text(technologyItem.keys.elementAt(6), style: TextStyle(fontSize: 10),), value: technologyItem.values.elementAt(6)),
];

var funMenuItem = <DropdownMenuItem<int>>[
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(0), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(0)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(1), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(1)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(2), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(2)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(3), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(3)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(4), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(4)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(5), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(5)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(6), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(6)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(7), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(7)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(8), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(8)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(9), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(9)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(10), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(10)),
  DropdownMenuItem<int>(child: Text(funItem.keys.elementAt(11), style: TextStyle(fontSize: 10),), value: funItem.values.elementAt(11)),
];


var marketMenuItem = <DropdownMenuItem<int>>[
  DropdownMenuItem<int>(child: Text(marketItem.keys.elementAt(0), style: TextStyle(fontSize: 10),), value: marketItem.values.elementAt(0)),
  DropdownMenuItem<int>(child: Text(marketItem.keys.elementAt(1), style: TextStyle(fontSize: 10),), value: marketItem.values.elementAt(1)),
  DropdownMenuItem<int>(child: Text(marketItem.keys.elementAt(2), style: TextStyle(fontSize: 10),), value: marketItem.values.elementAt(2))
];

List<DropdownMenuItem<int>> getMenuItem(String type) {
  var result;
  switch(type) {
    case '成电校园':
      result = schoolMenuItem;
      break;
    case '科技交流':
      result = technologyMenuItem;
      break;
    case '休闲娱乐':
      result = funMenuItem;
      break;
    case '跳蚤市场':
      result = marketMenuItem;
      break;
  }
  return result;
}

getChildMenuItem(List<ClassificationType> list) {
  var result = <DropdownMenuItem<int>>[];
  for (int i = 0; i < list.length; i++) {
    var item = DropdownMenuItem<int>(child: Text(list[i].classificationType_name, style: TextStyle(fontSize: 10),), value: list[i].classificationType_id);
    result.add(item);
  }
  return result;
}