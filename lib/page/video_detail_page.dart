import 'package:flutter/material.dart';
import 'package:flutter_bili_app/mode/video_model.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage(this.videoModel,{super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('详情页面'),
      ),
      body: Container(
        child: Text('视频 ID = ${widget.videoModel.vid}'),
      ),
    );
  }
}
