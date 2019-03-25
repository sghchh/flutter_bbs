
import 'package:flutter/material.dart';

/// 用来显示帖子内容中图片的界面
class ImagePage extends StatelessWidget {
  String url;

  ImagePage({this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        child: ConstrainedBox(constraints: BoxConstraints.expand(),
        child: Image.network(url,
          fit: BoxFit.contain,),),
        onTap: (){
          Navigator.of(context).pop();
        },
      )
    );
  }

}