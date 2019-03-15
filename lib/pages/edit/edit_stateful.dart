
import 'package:flutter_bbs/pages/edit/edit_menu_item.dart';

import 'package:flutter/material.dart';

///created by sgh    2019-02-28
/// 编辑帖子的界面的底部选择板块的UI
class EditWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _EditState();
  }
}

class _EditState extends State<EditWidget> {

  var typeValue;
  var boardValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          child: DropdownButton<String>(items: typeMenuItem,
            onChanged: (value) {setState(() {
              typeValue = value;
            });},
            hint: Text('选择分类', style: TextStyle(
                color: Colors.grey, fontSize: 16)),
            value: typeValue,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: DropdownButton<String>(items: typeValue == null ? null : getMenuItem(typeValue),
            onChanged: (value) {setState(() {
              boardValue = value;
            });},
            hint: Text('板块分类', style: TextStyle(
                color: Colors.grey, fontSize: 16)),
            value: boardValue,
          ),
        ),
        Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(left: 16, right: 5),
            child: IconButton(icon: Icon(Icons.send, color: Colors.blue),
              onPressed: null,
              iconSize: 36,
            )
        ),

      ],
    );
  }
}