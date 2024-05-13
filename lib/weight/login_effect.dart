import 'package:flutter/material.dart';

/// 登录图片效果

class LoginEffect extends StatefulWidget {
  final bool protect; // 是否为隐藏状态
  const LoginEffect({super.key, required this.protect});

  @override
  State<LoginEffect> createState() => _MaterialColorState();
}

class _MaterialColorState extends State<LoginEffect> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: const Border(bottom: BorderSide(color: Colors.grey))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,// 两边对齐，其余中间平分
        children: [
          _image(true),
          const Image(height: 90, width: 90, image: AssetImage('images/logo.png')),
          _image(false),
        ],
      ),
    );
  }

  _image(bool left) {
    var headLeft = widget.protect
        ? 'images/head_left_protect.png'
        : 'images/head_left.png';
    var headRight = widget.protect
        ? 'images/head_right_protect.png'
        : 'images/head_right.png';
    return Image(height: 90, image: AssetImage(left ? headLeft : headRight));

  }
}
