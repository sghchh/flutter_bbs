import 'package:flutter/material.dart';

class DetailWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return DetailState();
  }
}

class DetailState extends State<DetailWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 1),
            child: Text('帖子标题', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),),
          ),
          Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6),
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/c.jpg'),
                  radius: 28,
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text('Username', style: TextStyle(fontSize: 16, color: Colors.black),),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 6),
                    child: Text('PostTime', style: TextStyle(fontSize: 10, color: Colors.grey),),
                  ),
                ],
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            padding: EdgeInsets.only(left: 12, right: 10),
            child: Divider(height: 1, color: Colors.blueGrey,),
          ),
          Container(
            padding: EdgeInsets.only(left: 14, right: 10, top: 6, bottom: 6),
            child: Text("content", style: TextStyle(fontSize: 16,),
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12, right: 10),
            child: Divider(height: 1, color: Colors.grey,),
          ),
          Container(
            padding: EdgeInsets.only(left: 14, right: 12),
            child: Text("评论", style: TextStyle(fontSize: 16, color: Colors.grey),
              maxLines: 100,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 12, right: 10),
            child: Divider(height: 1, color: Colors.blueGrey,),
          ),
          Flexible(child: ListView.builder(itemBuilder: _buildListItem, itemCount: 10,),)
        ],
      ),
    );
  }

  //构建列表项的item
  Widget _buildListItem(context, index) {
    return Container(
      padding: EdgeInsets.only(top: 12, left: 6, right: 6, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(backgroundImage: AssetImage('images/c.jpg'), radius: 24,),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 4, bottom: 2, right: 16),
                      child: Text('Username', style: TextStyle(fontSize: 20,),),
                    ),
                    Text('Layer Number ${index}', style: TextStyle(fontSize: 12, color: Colors.grey),)
                  ],
                ),
                Container(
                    padding: EdgeInsets.only(left: 4, bottom: 2),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Time', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    )
                ),
                Container(
                    decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.lightBlueAccent, width: 2))),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Reply', style: TextStyle(fontSize: 16, color: Colors.grey), maxLines: 3, softWrap: true, overflow: TextOverflow.ellipsis,),
                    )
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Content', style: TextStyle(fontSize: 16, color: Colors.black), maxLines: 20, softWrap: true, overflow: TextOverflow.ellipsis,),
                  ),
                  padding: EdgeInsets.only(bottom: 6, top: 6),
                ),
                Align(
                  child: FlatButton(onPressed: null, child: Text('回复', style: TextStyle(color: Colors.blue),)),
                  alignment: Alignment.centerRight,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}