import 'package:chart_demo/common/bar/chart_bar.dart';
import 'package:chart_demo/common/bar/chart_bean_bar.dart';
import 'package:chart_demo/common/chart_bean.dart';
import 'package:chart_demo/common/painter_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///柱状图组件
class ChartBarWidget extends StatefulWidget {
  ChartBarWidget({
    super.key,
    required this.xValues,
    required this.yValues,
    required this.barDataList,
    required this.yMax,
    required this.rectWidth,
    this.rectSpace,
    this.customerBarColors,
    this.allBarColor,
    this.barRadius,
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
    this.duration,
    this.isShowX,
    this.chartSize,
  }) {
    //这三个参数，如果有值，那必须长度都一致，否则会内部处理错误
    var xLength = xValues.length;
    var barLength = barDataList.length;
    assert(xLength == barLength);
    if (customerBarColors != null) {
      var colorLength = customerBarColors?.length ?? 0;
      assert(xLength == colorLength);
    }
  }

  //X轴的数据
  final List<String?> xValues;

  //Y轴的数据
  final List<YValue> yValues;

  //柱状图的数据,单个Y轴支持展示多个柱子
  final List<List<num?>?> barDataList;

  //柱状图的颜色📊每个柱状图都支持渐变色，所以可以传入多个色值
  final List<List<Color>?>? customerBarColors;

  //可以指定所有柱状图都是同样的颜色📊
  //与[customerBarColors]冲突，只能传入一个有效参数，默认为[allBarColor]
  final List<Color>? allBarColor;

  //柱状图📊的圆角
  final double? barRadius;

  //xy轴的单位。你可以自己定义单位样式以及位置
  final List<UnitXY>? units;

  //默认在左上位置的单位
  final TopLeftUnit? topLeftUnit;

  //柱状图的宽度
  final double rectWidth;

  //柱体之间的间距,默认5
  final double? rectSpace;

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

  // 动画的时长，默认不设置表示没有动画
  final Duration? duration;

  //是否显示x轴文本,
  final bool? isShowX;

  //统计图大小
  final Size? chartSize;

  @override
  State createState() {
    return _ChartBarWidgetState();
  }
}

class _ChartBarWidgetState extends State<ChartBarWidget> {
  @override
  Widget build(BuildContext context) {
    return ChartBar(
      xDialValues: xDialValues(),
      baseLineY: 0,
      baseBean: BaseBean(
          //Y轴刻度字体样式与高度
          yDialValues: yDialValues(),
          yMax: widget.yMax,
          yMin: widget.yMin ?? 0.0,
          xyLineWidth: widget.xyLineWidth ?? 1,
          //X轴主线的颜色
          xColor: widget.xColor ?? Colors.white,
          //Y轴主线的颜色
          yColor: widget.yColor ?? Colors.transparent,
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
          //是否显示X轴的文本
          isShowX: widget.isShowX ?? true,
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
      size: widget.chartSize ??
          Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height / 5 * 1.8,
          ),
      //柱状图的宽
      rectWidth: widget.rectWidth,
      rectSpace: widget.rectSpace ?? 5,
      duration: widget.duration ?? const Duration(seconds: 1),
    );
  }

  ///初始化X轴底部标题数据、对应的柱子数据和样式
  List<ChartBarBeanX> xDialValues() {
    List<ChartBarBeanX> xValues = [];
    if (widget.xValues.isNotEmpty) {
      //遍历X轴数据
      for (int i = 0; i < widget.xValues.length; i++) {
        var title = widget.xValues[i];
        //取出柱状图数据
        var barList = widget.barDataList[i];

        List<ChartBarBeanXCell> beanXModels = [];
        //可能有多个柱子
        for (int j = 0; j < (barList?.length ?? 0); j++) {
          var barItem = barList?[j];
          beanXModels.add(ChartBarBeanXCell(
            //柱子的数据
            value: barItem?.toDouble(),
            //柱子的颜色与样式
            sectionColors: [
              SectionColor(
                starRate: 0,
                endRate: 1,
                gradualColor: widget.allBarColor ?? (widget.customerBarColors?[i] ?? []),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.barRadius ?? 50),
                    topRight: Radius.circular(widget.barRadius ?? 50)),
              ),
            ],
          ));
        }
        //X轴添加标题数据与柱子数据
        xValues.add(ChartBarBeanX(
          xBottomTextModel:
              TextSetModel(title: title ?? "", titleStyle: widget.xTextStyle ?? defaultTextStyle),
          beanXModels: beanXModels,
        ));
      }
    }

    return xValues;
  }

  ///初始化Y轴数据、样式
  List<DialStyleY> yDialValues() {
    List<DialStyleY> yDataList = [];

    if (widget.yValues.isNotEmpty) {
      //取出Y轴数据长度
      var vLength = widget.yValues.length;
      //Y轴每个刻度之间间隔高度
      var itemHeight = (widget.yItemHeight ?? 50);
      //计算Y轴高度 (计算每一行高度要-1是为了去掉第0行，否则多一行数据呈现错乱)
      var vHeight = (vLength - 1) * itemHeight;

      //初始化Y轴数据、样式
      for (int i = 0; i < vLength; i++) {
        var value = widget.yValues[i];
        yDataList.add(DialStyleY(
            leftSub: DialStyleYSub(
              title: value.title,
              titleStyle: widget.yTextStyle ?? const TextStyle(color: Colors.white, fontSize: 10),
              centerSubTitle: '',
              centerSubTextStyle:
                  widget.yTextStyle ?? const TextStyle(color: Colors.white, fontSize: 10),
            ),
            yValue: value.value,
            positionRetioy: (itemHeight * i) / vHeight));
      }
    }

    return yDataList;
  }
}
