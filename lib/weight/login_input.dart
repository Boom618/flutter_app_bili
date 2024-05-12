import 'package:flutter/material.dart';

import '../util/color.dart';

/// 登录输入框
class LoginInput extends StatefulWidget {
  const LoginInput(this.title, this.hint,
      {super.key,
      this.onChange,
      this.focusChange,
      this.lineStretch = false,
      this.obscureText = false,
      this.keyboardType});

  final String title;
  final String hint;
  final ValueChanged<String>? onChange; // 监听文本信息
  final ValueChanged<bool>? focusChange; // 监听是否为密码框
  final bool lineStretch; // 下划线
  final bool obscureText; // 是否密码输入
  final TextInputType? keyboardType; // 输入框类型

  @override
  State<LoginInput> createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode(); // 焦点监听

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      if (widget.focusChange != null) {
        widget.focusChange!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 释放焦点
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
            ),
            _input()
          ],
        ),
        // 下划线
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          child: const Divider(
            height: 1,
            thickness: 0.5,
          ),
        )
      ],
    );
  }

  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChange,
      obscureText: widget.obscureText,
      // 密文，明文
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText,
      cursorColor: primary,
      // 光标颜色
      style: const TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w300),
      // 输入框样式
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint ?? '',
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey)),
    ));
  }
}
