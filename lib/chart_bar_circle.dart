
import 'package:flutter/material.dart';

import 'common/bar/chart_bar.dart';
import 'common/bar/chart_bean_bar.dart';
import 'common/chart_bean.dart';

class ChartBarCirclePage extends StatefulWidget {
  static const String routeName = 'chart_bar_circle';
  static const String title = '柱状顶部半圆型';

  const ChartBarCirclePage({super.key});
  @override
  State<ChartBarCirclePage> createState() => _ChartBarCircleState();
}

class _ChartBarCircleState extends State<ChartBarCirclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildChartBarCircle(context),
    );
  }

  ///bar-circle
  Widget _buildChartBarCircle(context) {
    var chartBar = ChartBar(
      xDialValues: [
        ChartBarBeanX(
          xBottomTextModel: TextSetModel(title: '12-01'),
          beanXModels: [
            ChartBarBeanXCell(
              value: 50,
              sectionColors: [
                SectionColor(
                  starRate: 0,
                  endRate: 1,
                  gradualColor: [Color(0xFFF68D00), Color(0xFFFFB451)],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
              ],
            )
          ],
        ),
        ChartBarBeanX(
          xBottomTextModel: TextSetModel(title: '12-02'),
          beanXModels: [
            ChartBarBeanXCell(
              value: 100,
              sectionColors: [
                SectionColor(
                  starRate: 0,
                  endRate: 1,
                  gradualColor: [Colors.yellow, Colors.yellow],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                )
              ],
            ),
          ],
        ),
        ChartBarBeanX(
          xBottomTextModel: TextSetModel(title: '12-03'),
          beanXModels: [
            ChartBarBeanXCell(
              value: 30,
              sectionColors: [
                SectionColor(
                  starRate: 0.4,
                  endRate: 1,
                  gradualColor: [Colors.green, Colors.green],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                )
              ],
            ),
            ChartBarBeanXCell(
              value: 30,
              sectionColors: [
                SectionColor(
                  starRate: 0,
                  endRate: 0.4,
                  gradualColor: [Colors.orange, Colors.orange],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                )
              ],
            ),
          ],
        ),
        ChartBarBeanX(
          xBottomTextModel: TextSetModel(title: '12-04'),
          beanXModels: [
            ChartBarBeanXCell(
              value: 70,
              sectionColors: [
                SectionColor(
                  starRate: 0,
                  endRate: 1,
                  gradualColor: [Colors.blue, Colors.blue],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                )
              ],
            ),
          ],
        ),
        ChartBarBeanX(
          xBottomTextModel: TextSetModel(title: '12-05'),
          beanXModels: [
            ChartBarBeanXCell(
              value: 30,
              sectionColors: [
                SectionColor(
                  starRate: 0,
                  endRate: 1,
                  gradualColor: [Colors.deepPurple, Colors.deepPurple],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                )
              ],
            ),
            ChartBarBeanXCell(
              value: 40,
              sectionColors: [
                SectionColor(
                  starRate: 0,
                  endRate: 1,
                  gradualColor: [Colors.orange, Colors.orange],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
              ],
            ),
            ChartBarBeanXCell(
              value: 50,
              sectionColors: [
                SectionColor(
                  starRate: 0,
                  endRate: 1,
                  gradualColor: [Colors.white, Colors.white],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                ),
              ],
            ),
          ],
        ),
        ChartBarBeanX(
          xBottomTextModel: TextSetModel(title: '12-06'),
          beanXModels: [
            ChartBarBeanXCell(
              value: 90,
              sectionColors: [
                SectionColor(
                  starRate: 0,
                  endRate: 1,
                  gradualColor: [Colors.deepOrange, Colors.deepOrange],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                )
              ],
            ),
          ],
        ),
        ChartBarBeanX(
          xBottomTextModel: TextSetModel(title: '12-07'),
          beanXModels: [
            ChartBarBeanXCell(
              value: 50,
              sectionColors: [
                SectionColor(
                  starRate: 0,
                  endRate: 1,
                  gradualColor: [Colors.greenAccent, Colors.greenAccent],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                )
              ],
            ),
          ],
        )
      ],
      baseLineY: 0,
      baseBean: BaseBean(
        yDialValues: [
          DialStyleY(
              leftSub: DialStyleYSub(
                title: '100',
                titleStyle:
                    const TextStyle(color: Colors.white, fontSize: 10),
                centerSubTitle: '',
                centerSubTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 10),
              ),
              yValue: 100,
              positionRetioy: 100 / 100),
          DialStyleY(
              leftSub: DialStyleYSub(
                title: '65',
                titleStyle:
                    const TextStyle(color: Colors.white, fontSize: 10),
                centerSubTitle: '',
                centerSubTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 10),
              ),
              yValue: 65,
              positionRetioy: 65 / 100),
          DialStyleY(
              leftSub: DialStyleYSub(
                title: '35',
                titleStyle:
                    const TextStyle(color: Colors.white, fontSize: 10),
                centerSubTitle: '',
                centerSubTextStyle:
                    const TextStyle(color: Colors.white, fontSize: 10),
              ),
              yValue: 35,
              positionRetioy: 35 / 100)
        ],
        yMax: 100.0,
        yMin: 0.0,
        isShowHintX: true
      ),
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height / 5 * 1.8),
      //柱状图的宽
      rectWidth: 30,
      rectSpace: 5,
      duration: Duration(seconds: 1),
    );
    return chartBar;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      semanticContainer: true,
      color: Colors.black,
      clipBehavior: Clip.antiAlias,
      child: chartBar,
    );
  }
}
