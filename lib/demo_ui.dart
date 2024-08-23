import 'dart:ui';

import 'package:chart_demo/chart_widget/chart_bar_widget.dart';
import 'package:chart_demo/chart_widget/chart_line_widget.dart';
import 'package:chart_demo/common/chart_bean.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'chart_bar_circle.dart';
import 'chart_widget/hybrid_chart_widget.dart';
import 'common/line/chart_bean_line_common.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int type = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button("折线图", () {
                  setState(() {
                    type = 0;
                  });
                }, type == 0),
                button("柱状图", () {
                  setState(() {
                    type = 1;
                  });
                }, type == 1),
                button("柱线组合图", () {
                  setState(() {
                    type = 2;
                  });
                }, type == 2),
              ],
            ),
            showWidget()
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget button(String title, GestureTapCallback? onTap, bool selected) {
    return InkWell(
        onTap: onTap,
        child: Container(
            color: selected ? Colors.orange : Colors.green,
            alignment: Alignment.center,
            width: 100,
            height: 40,
            child: Text(title)));
  }

  Widget showWidget() {
    if (type == 0) {
      return _chartLine();
    } else if (type == 1) {
      return _chartBar();
    } else {
      return _chartHybrid();
    }
  }

  //折线图
  Widget _chartLine() {
    List<String?> xValues = ["00:00", "06:00", "12:00", "18:00", "24:00"];

    List<YValue> yValues = [
      YValue(value: 0, title: "0"),
      YValue(value: 10, title: "10"),
      YValue(value: 20, title: "20"),
      YValue(value: 30, title: "30"),
      YValue(value: 40, title: "40"),
      YValue(value: 50, title: "50"),
    ];

    List<List<num?>?>? lineDataList = [];
    var dataArr1 = [20.0, 41.0, 10.0, 22.0, 15.0, 20.0, 33.0, 20.0];
    var dataArr2 = [14.0, 20.0, 12.0, 14.0, 35.0, 40.0, 26.0, 10.0];
    lineDataList.add(dataArr1);
    lineDataList.add(dataArr2);

    List<Color>? lineColors = [Colors.orange, Colors.green];

    List<LineShaderSetModel?>? lineShaderList = [];
    var model1 = LineShaderSetModel(
        baseLineBottomGradient: LinearGradientModel(
            shaderColors: [Colors.white.withOpacity(0.01), Colors.white.withOpacity(0.3)]),
        baseLineTopGradient: LinearGradientModel(
            shaderColors: [Colors.orange.withOpacity(0.3), Colors.orange.withOpacity(0.01)]),
        baseLineY: 0,
        shaderIsContentFill: false);

    var model2 = LineShaderSetModel(
        baseLineBottomGradient: LinearGradientModel(
            shaderColors: [Colors.white.withOpacity(0.01), Colors.white.withOpacity(0.3)]),
        baseLineTopGradient: LinearGradientModel(
            shaderColors: [Colors.green.withOpacity(0.3), Colors.green.withOpacity(0.01)]),
        baseLineY: 0,
        shaderIsContentFill: false);

    lineShaderList.add(model1);
    lineShaderList.add(model2);

    return ChartLineWidget(
      //X轴主线的颜色
      xColor: Colors.white,
      //Y轴主线的颜色
      yColor: Colors.transparent,
      xValues: xValues,
      yValues: yValues,
      yMax: 50,
      lineDataList: lineDataList,
      lineColors: lineColors,
      lineShaderList: lineShaderList,
      isCurve: true,
      lineWidth: 2,
      topLeftUnit: TopLeftUnit(title: "单位：kw"),
      yItemHeight: 50,
      xyLineWidth: 1,
    );
  }

  //柱状图
  Widget _chartBar() {
    var xValues = ['00:00', '06:00', '12:00', '18:00', '24:00'];

    List<List<num?>?> barDataList = [
      [12.0, 20.0],
      [12.0, 20.0],
      [12.0, 20.0],
      [12.0, 20.0],
      [12.0, 20.0]
    ];

    var yValues = [
      YValue(value: 0, title: "0"),
      YValue(value: 10, title: "10"),
      YValue(value: 20, title: "20"),
      YValue(value: 30, title: "30"),
      YValue(value: 40, title: "40"),
      YValue(value: 50, title: "50"),
    ];
    return ChartBarWidget(
      xValues: xValues,
      yValues: yValues,
      barDataList: barDataList,
      yMax: 50,
      rectWidth: 30,
      rectSpace: 4,
      allBarColor: [Color(0xFF86B81B), Color(0xFF86B81B)],
    );
  }

  Widget _chartHybrid() {
    //折线图的数据
    List<List<num?>?>? lineDataList = [];
    var dataArr1 = [20.0, 41.0, 10.0, 22.0, 15.0, 20.0, 33.0, 20.0];
    var dataArr2 = [14.0, 20.0, 12.0, 14.0, 35.0, 40.0, 26.0, 10.0];
    lineDataList.add(dataArr1);
    lineDataList.add(dataArr2);

    List<Color>? lineColors = [Colors.orange, Colors.green];

    List<LineShaderSetModel?>? lineShaderList = [];
    var model1 = LineShaderSetModel(
        baseLineBottomGradient: LinearGradientModel(
            shaderColors: [Colors.white.withOpacity(0.01), Colors.white.withOpacity(0.3)]),
        baseLineTopGradient: LinearGradientModel(
            shaderColors: [Colors.orange.withOpacity(0.3), Colors.orange.withOpacity(0.01)]),
        baseLineY: 0,
        shaderIsContentFill: false);

    var model2 = LineShaderSetModel(
        baseLineBottomGradient: LinearGradientModel(
            shaderColors: [Colors.white.withOpacity(0.01), Colors.white.withOpacity(0.3)]),
        baseLineTopGradient: LinearGradientModel(
            shaderColors: [Colors.green.withOpacity(0.3), Colors.green.withOpacity(0.01)]),
        baseLineY: 0,
        shaderIsContentFill: false);

    lineShaderList.add(model1);
    lineShaderList.add(model2);

    //柱状图的数据
    var xValues = ['00:00', '06:00', '12:00', '18:00', '24:00'];

    List<List<num?>?> barDataList = [
      [32.0, 50.0],
      [22.0, 40.0],
      [12.0, 20.0],
      [33.0, 43.0],
      [12.0, 21.0]
    ];

    var yValues = [
      YValue(value: 0, title: "0"),
      YValue(value: 10, title: "10"),
      YValue(value: 20, title: "20"),
      YValue(value: 30, title: "30"),
      YValue(value: 40, title: "40"),
      YValue(value: 50, title: "50"),
    ];

    return HybridChartWidget(
      size: Size(
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 5 * 1.8,
      ),
      yMax: 50,
      rectWidth: 30,
      lineWidth: 2,
      lineDataList: lineDataList,
      lineShaderList: [],
      lineColors: lineColors,
      yItemHeight: 50,
      xValues: xValues,
      yValues: yValues,
      barDataList: barDataList,
      rectSpace: 4,
      allBarColor: [Color(0xFF86B81B), Color(0xFF86B81B)],
      topLeftUnit: TopLeftUnit(title: "单位：kw"),
    );
  }
}
