import 'package:flutter/material.dart';

///created by sgh    2019-2-23
/// 编辑帖子界面选择板块的item
var typeItem = <String>['成电校园','科技交流','休闲娱乐','跳蚤市场','站务管理'];    //类型的list
var schoolItem = <String>['就业创业','学术交流','出国留学','情感专区','成电锐评','校园热点','学术交流','交通出行','成电轨迹','考试专区','同城同乡','毕业感言','新生专区'];
var technologyItem = <String>['自然科学','前端之美','科技资讯','数字前端','电脑FAQ','硬件数码','Unix/Linux','程序员','电子设计'];
var funItem = <String>['水手之家','吃喝玩乐','成电骑迹','视觉艺术','军事国防','情系舞缘','音乐空间','文人墨客','体坛风云','影视天地','影视天地','动漫时代','跑步公园'];
var marketItem = <String>['二手专区','房屋租赁','店铺专区'];
var manageItem = <String>['站务公告','站务综合'];

var typeMenuItem = <DropdownMenuItem<String>>[
  DropdownMenuItem<String>(child: Text(typeItem[0]), value: typeItem[0]),
  DropdownMenuItem<String>(child: Text(typeItem[1]), value: typeItem[1]),
  DropdownMenuItem<String>(child: Text(typeItem[2]), value: typeItem[2]),
  DropdownMenuItem<String>(child: Text(typeItem[3]), value: typeItem[3]),
  DropdownMenuItem<String>(child: Text(typeItem[4]), value: typeItem[4])
];

var schoolMenuItem = <DropdownMenuItem<String>>[
  DropdownMenuItem<String>(child: Text(schoolItem[0]), value: schoolItem[0]),
  DropdownMenuItem<String>(child: Text(schoolItem[1]), value: schoolItem[1]),
  DropdownMenuItem<String>(child: Text(schoolItem[2]), value: schoolItem[2]),
  DropdownMenuItem<String>(child: Text(schoolItem[3]), value: schoolItem[3]),
  DropdownMenuItem<String>(child: Text(schoolItem[4]), value: schoolItem[4]),
  DropdownMenuItem<String>(child: Text(schoolItem[5]), value: schoolItem[5]),
  DropdownMenuItem<String>(child: Text(schoolItem[6]), value: schoolItem[6]),
  DropdownMenuItem<String>(child: Text(schoolItem[7]), value: schoolItem[7]),
  DropdownMenuItem<String>(child: Text(schoolItem[8]), value: schoolItem[8]),
  DropdownMenuItem<String>(child: Text(schoolItem[9]), value: schoolItem[9]),
  DropdownMenuItem<String>(child: Text(schoolItem[10]), value: schoolItem[10]),
  DropdownMenuItem<String>(child: Text(schoolItem[11]), value: schoolItem[11]),
  DropdownMenuItem<String>(child: Text(schoolItem[12]), value: schoolItem[12]),
];

var technologyMenuItem = <DropdownMenuItem<String>>[
  DropdownMenuItem<String>(child: Text(technologyItem[0]), value: technologyItem[0]),
  DropdownMenuItem<String>(child: Text(technologyItem[1]), value: technologyItem[1]),
  DropdownMenuItem<String>(child: Text(technologyItem[2]), value: technologyItem[2]),
  DropdownMenuItem<String>(child: Text(technologyItem[3]), value: technologyItem[3]),
  DropdownMenuItem<String>(child: Text(technologyItem[4]), value: technologyItem[4]),
  DropdownMenuItem<String>(child: Text(technologyItem[5]), value: technologyItem[5]),
  DropdownMenuItem<String>(child: Text(technologyItem[6]), value: technologyItem[6]),
  DropdownMenuItem<String>(child: Text(technologyItem[7]), value: technologyItem[7]),
  DropdownMenuItem<String>(child: Text(technologyItem[8]), value: technologyItem[8])
];

var funMenuItem = <DropdownMenuItem<String>>[
  DropdownMenuItem<String>(child: Text(funItem[0]), value: funItem[0]),
  DropdownMenuItem<String>(child: Text(funItem[1]), value: funItem[1]),
  DropdownMenuItem<String>(child: Text(funItem[2]), value: funItem[2]),
  DropdownMenuItem<String>(child: Text(funItem[3]), value: funItem[3]),
  DropdownMenuItem<String>(child: Text(funItem[4]), value: funItem[4]),
  DropdownMenuItem<String>(child: Text(funItem[5]), value: funItem[5]),
  DropdownMenuItem<String>(child: Text(funItem[6]), value: funItem[6]),
  DropdownMenuItem<String>(child: Text(funItem[7]), value: funItem[7]),
  DropdownMenuItem<String>(child: Text(funItem[8]), value: funItem[8]),
  DropdownMenuItem<String>(child: Text(funItem[9]), value: funItem[9]),
  DropdownMenuItem<String>(child: Text(funItem[10]), value: funItem[10]),
  DropdownMenuItem<String>(child: Text(funItem[11]), value: funItem[11]),
  DropdownMenuItem<String>(child: Text(funItem[12]), value: funItem[12])
];

var manageMenuItem = <DropdownMenuItem<String>>[
  DropdownMenuItem<String>(child: Text(manageItem[0]), value: manageItem[0]),
  DropdownMenuItem<String>(child: Text(manageItem[1]), value: manageItem[1])
];

var marketMenuItem = <DropdownMenuItem<String>>[
  DropdownMenuItem<String>(child: Text(marketItem[0]), value: marketItem[0]),
  DropdownMenuItem<String>(child: Text(marketItem[1]), value: marketItem[1]),
  DropdownMenuItem<String>(child: Text(marketItem[2]), value: marketItem[2])
];

List<DropdownMenuItem<String>> getMenuItem(String type) {
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
    default:
      result = manageMenuItem;
  }
  return result;
}