import 'package:flutter/material.dart';

//点击的时候带出来的参数
class TouchBackModel {
  bool needRefresh;
  Offset? startOffset;
  Size size;
  dynamic backParam;
  int? index;
  TouchBackModel(
      {this.needRefresh = true,
      required this.startOffset,
      required this.size,
      this.index,
      this.backParam});
}

class BarTouchCellModel {
  //开始的点，左上角
  Offset begainPoint;
  //柱体的大小
  Size size;
  //数据下标
  int index;
  //柱体中间的x轴
  double get centerX => begainPoint.dx + size.width / 2;
  //柱体的点击外带参数
  dynamic param;
  BarTouchCellModel(
      {required this.begainPoint,
      required this.size,
      required this.index,
      this.param});
}
