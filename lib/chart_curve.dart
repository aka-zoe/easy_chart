import 'package:flutter/material.dart';

import 'common/chart_bean.dart';
import 'common/line/chart_bean_line.dart';
import 'common/line/chart_bean_line_common.dart';
import 'common/line/chart_line.dart';

class ChartCurvePage extends StatefulWidget {
  static const String routeName = 'chart_curve';
  static const String title = '平滑曲线带填充颜色';

  const ChartCurvePage({super.key});

  @override
  State<ChartCurvePage> createState() => _ChartCurveState();
}

class _ChartCurveState extends State<ChartCurvePage> {
  late ChartBeanSystem _chartLineBeanSystem;
  late ChartBeanSystem _chartLineBeanSystem2;

  @override
  void initState() {
    //X轴的数据集
    var dataArr1 = [2.0, 4.0, 0.0, 12.0, 15.0, 20.0, 13.0, 10.0];
    var dataArr2 = [4.0, 8.0, 1.0, 24.0, 30.0, 40.0, 26.0, 20.0];

    _chartLineBeanSystem = generateChartBeanSystem(dataArr1, const Color(0xFF86B81B));
    _chartLineBeanSystem2 = generateChartBeanSystem(dataArr2, const Color(0xFFC91BC8));
    super.initState();
  }

  ChartBeanSystem generateChartBeanSystem(List<num> dataArr, Color lineColor) {
    //X轴的数据集
    // var dataarr = [2.0, 4.0, 0.0, 12.0, 15.0, 20.0, 13.0, 10.0];
    var tempDatas = <ChartLineBean>[];
    for (var i = 0; i < dataArr.length; i++) {
      tempDatas.add(
        ChartLineBean(y: dataArr[i].toDouble(), xPositionRetioy: (1 / (dataArr.length - 1)) * i),
      );
    }
    return ChartBeanSystem(
      lineWidth: 2,
      //是否为平滑曲线
      isCurve: true,
      chartBeans: tempDatas,
      lineShader: LineShaderSetModel(
          baseLineBottomGradient: LinearGradientModel(
              shaderColors: [Colors.white.withOpacity(0.01), Colors.white.withOpacity(0.3)]),
          baseLineTopGradient: LinearGradientModel(
              shaderColors: [lineColor.withOpacity(0.3), lineColor.withOpacity(0.01)]),
          baseLineY: 0,
          shaderIsContentFill: false),
      lineColor: lineColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildChartCurve(context),
    );
  }

  ///curve
  Widget _buildChartCurve(context) {
    var xarr = ['0:00', '06:00', '12:00', '18:00', '24:00'];
    var tempXs = <DialStyleX>[];
    for (var i = 0; i < xarr.length; i++) {
      tempXs.add(
        DialStyleX(
            title: xarr[i],
            titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
            positionRetioy: (1 / (xarr.length - 1)) * i),
      );
    }
    var chartLine = ChartLine(
      bothEndPitchX: 0,
      xDialValues: tempXs,
      chartBeanSystems: [_chartLineBeanSystem, _chartLineBeanSystem2],
      size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height / 5 * 1.6),
      baseBean: BaseBean(
          //X轴主线的颜色
          xColor: Colors.white,
          //Y轴主线的颜色
          yColor: Colors.transparent,
          //Y轴刻度字体样式与高度
          yDialValues: [
            DialStyleY(
              leftSub: DialStyleYSub(
                  title: '0', titleStyle: const TextStyle(fontSize: 10.0, color: Colors.white)),
              //Y轴的值
              yValue: 0,
              //Y轴中每一行所处的位置，例如总高度250，当前Y值为0，那第一行在底部，则总高度除0
              positionRetioy: 0 / 250.0,
            ),
            DialStyleY(
              leftSub: DialStyleYSub(
                  title: '10', titleStyle: const TextStyle(fontSize: 10.0, color: Colors.white)),
              yValue: 10,
              //如果Y轴值的区间为0-50，除0值外，每一个区间的高度平均划分，第一个区间就是0-10，则是5分之1，为250/50
              positionRetioy: 50 / 250.0,
            ),
            DialStyleY(
              leftSub: DialStyleYSub(
                  title: '20', titleStyle: const TextStyle(fontSize: 10.0, color: Colors.white)),
              yValue: 20,
              positionRetioy: 100 / 250.0,
            ),
            DialStyleY(
              leftSub: DialStyleYSub(
                  title: '30', titleStyle: const TextStyle(fontSize: 10.0, color: Colors.white)),
              yValue: 30,
              positionRetioy: 150 / 250.0,
            ),
            DialStyleY(
              leftSub: DialStyleYSub(
                  title: '40', titleStyle: const TextStyle(fontSize: 10.0, color: Colors.white)),
              yValue: 40,
              positionRetioy: 200 / 250.0,
            ),
            DialStyleY(
              leftSub: DialStyleYSub(
                  title: '50', titleStyle: const TextStyle(fontSize: 10.0, color: Colors.white)),
              yValue: 50,
              positionRetioy: 250 / 250.0,
            )
          ],
          //Y轴刻度最大值
          yMax: 50.0,
          //Y轴刻度最小值
          yMin: 0.0,
          //是否显示X轴辅助线
          isShowHintX: true,
          //是否显示Y轴辅助线
          isShowHintY: false,
          //辅助线宽度，
          hintLineWidth: 0.5,
          //是否显示X轴刻度
          isShowXScale: false,
          //是否显示Y轴刻度
          isShowYScale: false,
          isShowBorderRight: false,
          //是否显示顶部边框
          isShowBorderTop: false,
          yDialLeftMain: true,
          //是否显示X轴的值
          isShowX: true,
          //辅助线是否为虚线
          isHintLineImaginary: false,
          //显示单位
          units: [
            UnitXY(
                baseOrientation: UnitOrientation.topLeft, text: "单位：kw", spaceDif: Offset(-15, 10))
          ]),
    );
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      semanticContainer: true,
      color: Colors.black,
      clipBehavior: Clip.antiAlias,
      child: chartLine,
    );
  }
}
