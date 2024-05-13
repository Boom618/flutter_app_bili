
import 'package:flutter/material.dart';
/// 自定义顶部 Bar
appBar(String title ,String rightTitle ,VoidCallback rightButtonClick){

  return AppBar(
    title: Text(title,style: const TextStyle(fontSize: 18),),
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(),// 返回按钮
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(rightTitle,style: TextStyle(fontSize: 18,color: Colors.grey[500]),textAlign: TextAlign.center,),
        ),
      )
    ],
  );

}