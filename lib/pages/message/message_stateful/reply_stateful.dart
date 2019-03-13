import 'package:flutter/material.dart';


/**
 * created by sgh    2019-2-28
 * 消息界面中“回复”的界面
 */
class MessageReplyWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _MessageReplyState();
  }
}

class _MessageReplyState extends State<MessageReplyWidget> with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: null,
      builder: (context, snaphot) {
        if (!snaphot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }
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
                              margin: EdgeInsets.only(left: 6),
                              padding: EdgeInsets.only(left: 6, top: 6, right: 3),
                              decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                              child: Text('Message', style: TextStyle(fontSize: 12, color: Colors.grey), textAlign: TextAlign.right,)
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
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}