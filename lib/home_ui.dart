import 'package:chart_demo/chart_bar_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chart_curve.dart';
import 'common/bar/chart_bar.dart';
import 'common/bar/chart_bean_bar.dart';
import 'common/chart_bean.dart';
import 'common/line/chart_bean_line.dart';
import 'common/line/chart_bean_line_common.dart';
import 'common/line/chart_line.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ChartBeanSystem _chartLineBeanSystem;
  late ChartBeanSystem _chartLineBeanSystem2;

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
  void initState() {
    //X轴的数据集
    var dataArr1 = [2.0, 4.0, 0.0, 12.0, 15.0, 20.0, 13.0, 10.0];
    var dataArr2 = [4.0, 8.0, 1.0, 24.0, 30.0, 40.0, 26.0, 20.0];

    _chartLineBeanSystem = generateChartBeanSystem(dataArr1, const Color(0xFF86B81B));
    _chartLineBeanSystem2 = generateChartBeanSystem(dataArr2, const Color(0xFFC91BC8));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        // child: _chart(),
          child: ChartCurvePage()
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _chart() {
    return Stack(
      children: [
        ChartBar(
          xDialValues: generaChartBarBean(),
          baseLineY: 0,
          baseBean: BaseBean(
              //X轴主线的颜色
              xColor: Color(0xFF5A5A5A),
              xyLineWidth:1,
              //Y轴主线的颜色
              yColor: Colors.transparent,
              //Y轴刻度字体样式与高度
              yDialValues: yDialValues(),
              //Y轴刻度最大值
              yMax: 50.0,
              isShowHintX: true,
              hintLineWidth: 1,
              hintLineColor: Color(0xFF5A5A5A),
              //显示单位
              units: [
                UnitXY(
                    baseOrientation: UnitOrientation.topLeft,
                    text: "单位：kw",
                    spaceDif: Offset(-15, 10))
              ]),
          size:
              Size(MediaQuery.of(context).size.width, 300),
          //柱状图的宽：总体的宽，如果当前一列有三个柱状图，那rectWidth=三个加起来的宽
          rectWidth: 28,
          rectSpace: 4,
          duration: Duration(seconds: 1),
        ),
        _buildChartCurve(context),
      ],
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

      baseBean: BaseBean(
          yDialValues: [],
          isShowX: false,
          isShowXScale: false,
          xColor: Colors.transparent,
          yColor: Colors.transparent),
      bothEndPitchX: 0,
      // xDialValues: tempXs,
      chartBeanSystems: [_chartLineBeanSystem, _chartLineBeanSystem2],
      size: Size(MediaQuery.of(context).size.width, 300),
    );
    return chartLine;
  }

  List<ChartBarBeanX> generaChartBarBean() {
    var xValueArray = ['00:00', '06:00', '12:00', '18:00', '24:00'];
    List<ChartBarBeanX> barBeanArray = [];
    for (var item in xValueArray) {
      barBeanArray.add(ChartBarBeanX(
        xBottomTextModel: TextSetModel(title: item),
        beanXModels: [
          ChartBarBeanXCell(
            value: 12,
            sectionColors: [
              SectionColor(
                starRate: 0,
                endRate: 1,
                gradualColor: [Color(0xFFC7C7C7), Color(0xFFC7C7C7)],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              )
            ],
          ),
          ChartBarBeanXCell(
            value: 20,
            sectionColors: [
              SectionColor(
                starRate: 0,
                endRate: 1,
                gradualColor: [Color(0xFF86B81B), Color(0xFF86B81B)],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              )
            ],
          ),
        ],
      ));
    }
    return barBeanArray;
  }

  List<DialStyleY> yDialValues() {
    return [
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
    ];
  }
}
