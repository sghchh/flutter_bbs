import 'package:flutter/material.dart';
import 'package:flutter_bbs/pages/edit/edit_menu_item.dart';


/**
 * created by sgh    2019-02-28
 * 编辑帖子的界面的底部选择板块的UI
 */
class EditWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditState();
  }
}

class _EditState extends State<EditWidget> {

  var mTypeValue = null;
  var mBoardValue = null;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8),
          child: DropdownButton<String>(items: typeMenuItem,
            onChanged: (value) {setState(() {
              mTypeValue = value;
              print(mTypeValue.runtimeType.toString() + '======================');
            });},
            hint: Text('选择分类', style: TextStyle(
                color: Colors.grey, fontSize: 16)),
            value: mTypeValue,
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          child: DropdownButton<String>(items: mTypeValue == null ? null : getMenuItem(mTypeValue),
            onChanged: (value) {setState(() {
              mBoardValue = value;
            });},
            hint: Text('板块分类', style: TextStyle(
                color: Colors.grey, fontSize: 16)),
            value: mBoardValue,
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