import 'package:chart_demo/chart_widget/chart_bar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/chart_bean.dart';
import '../common/line/chart_bean_line_common.dart';
import 'chart_line_widget.dart';

///柱状图与折线组合显示的组件
///内部采用Stack组件实现，将[ChartBarWidget]与[ChartLineWidget] 组合层叠显示
class HybridChartWidget extends StatefulWidget {
  HybridChartWidget({
    super.key,
    required this.size,
    required this.yMax,
    required this.xValues,
    required this.yValues,
    required this.rectWidth,
    this.rectSpace,
    this.lineDataList,
    this.lineColors,
    this.lineShaderList,
    this.isCurve,
    this.lineWidth,
    this.yMin,
    this.yItemHeight,
    this.xColor,
    this.yColor,
    this.units,
    this.topLeftUnit,
    this.barDataList,
    this.customerBarColors,
    this.allBarColor,
    this.barRadius,
  }) {
    //折线图的这三个参数，如果有值，那必须长度都一致，否则会内部处理错误
    var lineListLength = lineDataList?.length ?? 0;
    var lineColorsLength = lineColors?.length ?? 0;
    var lineShaderListLength = lineShaderList?.length ?? 0;
    if (lineDataList != null && lineColors != null) {
      assert(lineListLength == lineColorsLength);
    } else if (lineDataList != null && lineColors != null && lineShaderList != null) {
      assert(lineListLength == lineColorsLength && lineListLength == lineShaderListLength);
    }
  }

  final Size size;

  //X轴的数据
  final List<String?> xValues;

  //Y轴的数据
  final List<YValue> yValues;

  //折线的数据，支持多条折线
  final List<List<num?>?>? lineDataList;

  //折线的颜色,多个折线就传入多个color对象，与[lineDataList]对应
  final List<Color>? lineColors;

  //线条闭合曲线渐变颜色设置,如果为空则不需要渐变填充设置
  final List<LineShaderSetModel?>? lineShaderList;

  //柱状图的数据,单个Y轴支持展示多个柱子
  final List<List<num?>?>? barDataList;

  //柱状图的颜色📊每个柱状图都支持渐变色，所以可以传入多个色值
  final List<List<Color>?>? customerBarColors;

  //可以指定所有柱状图都是同样的颜色📊
  //与[customerBarColors]冲突，只能传入一个有效参数，默认为[allBarColor]
  final List<Color>? allBarColor;

  //柱状图📊的圆角
  final double? barRadius;

  //折线的线宽
  final double? lineWidth;

  //标记是否为曲线
  final bool? isCurve;

  //y轴最大值
  final double yMax;

  //y轴最小值
  final double? yMin;

  //Y轴每一个刻度之间的间距
  final double? yItemHeight;

  //x轴的颜色
  final Color? xColor;

  //y轴的颜色
  final Color? yColor;

  //柱状图的宽度
  final double rectWidth;

  //柱体之间的间距,默认5
  final double? rectSpace;

  //xy轴的单位。你可以自己定义单位样式以及位置
  final List<UnitXY>? units;

  //默认在左上位置的单位
  final TopLeftUnit? topLeftUnit;

  @override
  State createState() {
    return _HybridChartWidgetState();
  }
}

class _HybridChartWidgetState extends State<HybridChartWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size.width,
      height: widget.size.height,
      child: Stack(
        children: [_chartBar(), _chartLine()],
      ),
    );
  }

  //折线图
  Widget _chartLine() {
    return ChartLineWidget(
      //X轴主线的颜色
      xColor: Colors.transparent,
      //Y轴主线的颜色
      yColor: Colors.transparent,
      //混合图X轴与Y轴都在柱状组件里
      xValues: const [],
      yValues: const [],
      isShowHintX: false,
      yMax: widget.yMax,
      lineDataList: widget.lineDataList,
      lineColors: widget.lineColors,
      lineShaderList: widget.lineShaderList,
      isCurve: widget.isCurve ?? true,
      lineWidth: widget.lineWidth ?? 2,
      yItemHeight: widget.yItemHeight ?? 50,
      chartSize: widget.size,
    );
  }

  //柱状图
  Widget _chartBar() {
    return ChartBarWidget(
      xValues: widget.xValues,
      yValues: widget.yValues,
      barDataList: widget.barDataList ?? [],
      xColor: widget.xColor ?? Colors.white,
      yColor: widget.yColor ?? Colors.transparent,
      yMax: widget.yMax,
      rectWidth: widget.rectWidth,
      rectSpace: widget.rectSpace ?? 4,
      topLeftUnit: widget.topLeftUnit,
      units: widget.units,
      allBarColor: widget.allBarColor,
      customerBarColors: widget.customerBarColors,
      chartSize: widget.size,
    );
  }
}
