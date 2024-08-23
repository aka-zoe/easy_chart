import 'package:flutter/material.dart';

import 'chart_bean.dart';

class BasePainter extends CustomPainter {
  //基础设置
  late BaseBean baseBean;

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
