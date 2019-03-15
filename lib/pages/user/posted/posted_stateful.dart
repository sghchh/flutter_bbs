import 'package:flutter/material.dart';


///created by sgh    2019-2-23
/// User界面“我的发表”的UI
class PostedWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PostedState();
  }
}

class _PostedState extends State<PostedWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 8),
          decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          margin: const EdgeInsets.only(left: 2, right: 2, top: 2, bottom: 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10, right: 12),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/c.jpg'),
                  radius: 30,
                ),
              ),
              Flexible(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Username', style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('BoardId',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        textAlign: TextAlign.right,),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 2),
                      child: Text('PostTime',
                          style: TextStyle(fontSize: 12, color: Colors.grey))
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      child: Text('Content',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Icon(Icons.remove_red_eye, size: 18, color: Colors.grey,),
                      Container(
                        margin: const EdgeInsets.only(left: 6, right: 6),
                        child: Text('查看数',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                      Icon(Icons.chat_bubble_outline, size: 18,
                        color: Colors.grey,),
                      Container(
                        margin: const EdgeInsets.only(left: 6),
                        child: Text('回复数',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                    ],
                  )
                ],
              ),)
            ],
          ),
        );
      },
      itemCount: 3,
    );
  }
}