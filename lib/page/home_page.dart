import 'package:flutter/material.dart';

import '../mode/video_model.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<VideoModel>? onJumpToDetail;

  const HomePage({super.key, this.onJumpToDetail});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页 Bar'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('首页内容'),
            MaterialButton(
              onPressed: () => widget.onJumpToDetail!(VideoModel(vid: '111')),
              child: Text('详情'),
            )
          ],
        ),
      ),
    );
  }
}
