import 'package:flutter/material.dart';

/**
 * created by sgh     2019-2-28
 * 构建消息界面的"私信"界面
 */
class MessagePrivateWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MessagePrivateState();
  }
}

class _MessagePrivateState extends State<MessagePrivateWidget> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index){
          return Container(
              margin: EdgeInsets.only(top: 6, bottom: 6),
              padding: EdgeInsets.only(top: 6, left: 4, right: 4, bottom: 6),
              child: Row(children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('images/c.jpg'),
                    radius: 24,
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text('Username ${index}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.lightBlue)),
                          Text('MessageTime', style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.right,),
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 3, top: 4, right: 3),
                          child: Text('ReplyMessage', style: TextStyle(fontSize: 12), textAlign: TextAlign.right,)
                      )
                    ],),
                )
              ],
              )
          );

        });
  }
}