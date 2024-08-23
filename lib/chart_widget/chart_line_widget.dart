import 'package:chart_demo/common/chart_bean.dart';
import 'package:chart_demo/common/line/chart_bean_line.dart';
import 'package:chart_demo/common/line/chart_bean_line_common.dart';
import 'package:chart_demo/common/line/chart_line.dart';
import 'package:chart_demo/common/painter_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///折线图组件
class ChartLineWidget extends StatefulWidget {
  ChartLineWidget(
      {super.key,
      required this.xValues,
      required this.yValues,
      required this.yMax,
      this.lineDataList,
      this.lineColors,
      this.lineShaderList,
      this.lineWidth,
      this.isCurve,
      this.units,
      this.topLeftUnit,
      this.xyLineWidth,
      this.xColor,
      this.yColor,
      this.yItemHeight,
      this.yTextStyle,
      this.xTextStyle,
      this.yMin,
      this.isShowHintX,
      this.isShowHintY,
      this.hintLineColor,
      this.hintLineWidth,
      this.isHintLineImaginary,
      this.isShowXScale,
      this.isShowYScale,
      this.chartSize}) {
    //这三个参数，如果有值，那必须长度都一致，否则会内部处理错误
    var lineListLength = lineDataList?.length ?? 0;
    var lineColorsLength = lineColors?.length ?? 0;
    var lineShaderListLength = lineShaderList?.length ?? 0;
    if (lineDataList != null && lineColors != null) {
      assert(lineListLength == lineColorsLength);
    } else if (lineDataList != null && lineColors != null && lineShaderList != null) {
      assert(lineListLength == lineColorsLength && lineListLength == lineShaderListLength);
    }
  }

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

  //xy轴的单位。你可以自己定义单位样式以及位置
  final List<UnitXY>? units;

  //默认在左上位置的单位
  final TopLeftUnit? topLeftUnit;

  //折线线宽
  final double? lineWidth;

  //标记是否为曲线
  final bool? isCurve;

  //xy轴线条的宽度
  final double? xyLineWidth;

  //x轴的颜色
  final Color? xColor;

  //y轴的颜色
  final Color? yColor;

  //Y轴每一个刻度之间的间距
  final double? yItemHeight;

  //Y轴标题字体样式
  final TextStyle? yTextStyle;

  //X轴标题字体样式
  final TextStyle? xTextStyle;

  //y轴最大值
  final double yMax;

  //y轴最小值
  final double? yMin;

  //x轴辅助线
  final bool? isShowHintX;

  //y轴的辅助线
  final bool? isShowHintY;

  //辅助线颜色
  final Color? hintLineColor;

  //辅助线宽度
  final double? hintLineWidth;

  //辅助线是否为虚线
  final bool? isHintLineImaginary;

  //是否显示x轴刻度
  final bool? isShowXScale;

  //是否显示y轴刻度
  final bool? isShowYScale;

  //统计图大小
  final Size? chartSize;

  @override
  State createState() {
    return _ChartLineWidgetState();
  }
}

class _ChartLineWidgetState extends State<ChartLineWidget> {
  @override
  Widget build(BuildContext context) {
    return ChartLine(
      bothEndPitchX: 0,
      xDialValues: xDialValues(),
      chartBeanSystems: chartBeanSystems(),
      size: widget.chartSize ??
          Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 5 * 1.8,
          ),
      baseBean: BaseBean(
          xyLineWidth: widget.xyLineWidth ?? 1,
          //X轴主线的颜色
          xColor: widget.xColor ?? Colors.transparent,
          //Y轴主线的颜色
          yColor: widget.yColor ?? Colors.transparent,
          //Y轴刻度字体样式与高度
          yDialValues: yDialValues(),
          //Y轴刻度最大值
          yMax: widget.yMax,
          //Y轴刻度最小值
          yMin: widget.yMin ?? 0.0,
          //是否显示X轴辅助线
          isShowHintX: widget.isShowHintX ?? true,
          //是否显示Y轴辅助线
          isShowHintY: widget.isShowHintY ?? false,
          //辅助线宽度，
          hintLineWidth: widget.hintLineWidth ?? 0.5,
          //是否显示X轴刻度
          isShowXScale: widget.isShowXScale ?? false,
          //是否显示Y轴刻度
          isShowYScale: widget.isShowYScale ?? false,
          isShowBorderRight: false,
          //是否显示顶部边框
          isShowBorderTop: false,
          yDialLeftMain: true,
          //是否显示X轴的值
          isShowX: true,
          //辅助线是否为虚线
          isHintLineImaginary: widget.isHintLineImaginary ?? false,
          // basePadding: EdgeInsets.only(left: 20,right: 20),
          //显示单位
          units: widget.units ??
              [
                UnitXY(
                    baseOrientation: UnitOrientation.topLeft,
                    text: widget.topLeftUnit?.title ?? "",
                    textStyle: widget.topLeftUnit?.textStyle ?? defaultTextStyle,
                    spaceDif: const Offset(-15, 10))
              ]),
    );
  }

  ///初始化X轴数据
  List<DialStyleX>? xDialValues() {
    List<DialStyleX> xStyles = [];
    for (var i = 0; i < widget.xValues.length; i++) {
      xStyles.add(
        DialStyleX(
            title: widget.xValues[i] ?? "",
            titleStyle: widget.xTextStyle ?? const TextStyle(color: Colors.white, fontSize: 12),
            positionRetioy: (1 / (widget.xValues.length - 1)) * i),
      );
    }
    return xStyles;
  }

  ///初始化Y轴数据
  List<DialStyleY> yDialValues() {
    List<DialStyleY> yStyleList = [];

    if (widget.yValues.isNotEmpty == true) {
      //取出当前Y轴的刻度总数
      int count = widget.yValues.length;
      double itemHeight = (widget.yItemHeight ?? 50);
      //获取整个Y轴高度 (计算每一行高度要-1是为了去掉第0行，否则多一行数据呈现错乱)
      double totalYHeight = (count - 1) * itemHeight;
      //开始初始化Y轴数据
      for (int i = 0; i < count; i++) {
        YValue value = widget.yValues[i];

        var styleY = DialStyleY(
          leftSub: DialStyleYSub(
              title: value.title,
              titleStyle:
                  widget.yTextStyle ?? const TextStyle(fontSize: 10.0, color: Colors.white)),
          //Y轴的值
          yValue: value.value,
          //Y轴中每一行所处的位置，例如总高度250，当前Y值为0，那第一行在底部，则总高度除0
          positionRetioy: (i * itemHeight) / totalYHeight,
        );
        yStyleList.add(styleY);
      }
    }
    return yStyleList;
  }

  ///初始化折线数据：线条、颜色、渐变色
  List<ChartBeanSystem> chartBeanSystems() {
    List<ChartBeanSystem> systems = [];
    //初始化折线数据
    if (widget.lineDataList != null && widget.lineDataList?.isNotEmpty == true) {
      //遍历[lineDataList]取出折线数据
      for (int i = 0; i < (widget.lineDataList?.length ?? 0); i++) {
        List<num?>? lineList = widget.lineDataList?[i];

        //取出线条颜色，如果有的话，否则为默认颜色
        Color lineColor = Colors.orange;
        if (widget.lineColors != null && (widget.lineColors?.length ?? 0) > i) {
          lineColor = widget.lineColors?[i] ?? Colors.orange;
        }

        //取出折线渐变颜色，如果有的话，为null则不赋值
        LineShaderSetModel? lineShader;
        if (widget.lineShaderList != null && (widget.lineShaderList?.length ?? 0) > i) {
          lineShader = widget.lineShaderList?[i];
        }

        //添加折线数据到数组中
        systems.add(generateChartBeanSystem(lineList, lineColor, lineShader));
      }
    }
    return systems;
  }

  ///初始化折线：数据、样式
  ///[dataArr]    折线数据
  ///[lineColor]  线条颜色
  ///[lineShader] 折线渐变颜色
  ChartBeanSystem generateChartBeanSystem(
      List<num?>? dataArr, Color lineColor, LineShaderSetModel? lineShader) {
    //线轴的数据集
    var tempDatas = <ChartLineBean>[];
    for (var i = 0; i < (dataArr?.length ?? 0); i++) {
      tempDatas.add(
        ChartLineBean(
            y: dataArr?[i]?.toDouble(), xPositionRetioy: (1 / ((dataArr?.length ?? 0) - 1)) * i),
      );
    }
    return ChartBeanSystem(
      //线宽
      lineWidth: widget.lineWidth ?? 2,
      //是否为平滑曲线
      isCurve: widget.isCurve ?? false,
      chartBeans: tempDatas,
      lineShader: lineShader,
      lineColor: lineColor,
    );
  }
}
