import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example6 = Example(
  name: 'Customize the indicator as you wish. ',
  description: 'The default indicator is a circle, and you can customize it '
      'as you wish.\nWith IndicatorStyle you can change the color, the X/Y '
      'position based on values from 0.0 to 1.0 or give it a padding.\n'
      'You must explicitly provide its height/width (depending on axis) though.',
  code: '''
return Container(
  color: Colors.white,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      TimelineTile(
        alignment: TimelineAlign.center,
        isFirst: true,
        indicatorStyle: const IndicatorStyle(
          width: 20,
          color: Colors.purple,
          indicatorXY: 0.2,
          padding: EdgeInsets.all(8),
        ),
        startChild: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
          ),
          color: Colors.amberAccent,
        ),
      ),
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          width: 10,
          color: Colors.black,
          padding: EdgeInsets.only(
            top: 8,
            left: 4,
            right: 4,
          ),
        ),
        startChild: Container(
          height: 50,
          color: Colors.purple,
        ),
        endChild: Container(
          color: Colors.cyan,
        ),
      ),
      TimelineTile(
        alignment: TimelineAlign.center,
        isLast: true,
        indicatorStyle: const IndicatorStyle(
          width: 30,
          color: Colors.red,
          indicatorXY: 0.3,
        ),
        endChild: Container(
          constraints: const BoxConstraints(
            minHeight: 80,
          ),
          color: Colors.lightGreenAccent,
        ),
      ),
    ],
  ),
);''',
  childVertical: Example6Vertical(),
  childHorizontal: Example6Horizontal(),
);

class Example6Vertical extends StatelessWidget {
  const Example6Vertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TimelineTile(
                  alignment: TimelineAlign.center,
                  isFirst: true,
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.purple,
                    indicatorXY: 0.2,
                    padding: EdgeInsets.all(8),
                  ),
                  startChild: Container(
                    constraints: const BoxConstraints(
                      minHeight: 120,
                    ),
                    color: Colors.amberAccent,
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.center,
                  indicatorStyle: const IndicatorStyle(
                    width: 10,
                    color: Colors.black,
                    padding: EdgeInsets.only(
                      top: 8,
                      left: 4,
                      right: 4,
                    ),
                  ),
                  startChild: Container(
                    height: 50,
                    color: Colors.purple,
                  ),
                  endChild: Container(
                    color: Colors.cyan,
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.center,
                  isLast: true,
                  indicatorStyle: const IndicatorStyle(
                    width: 30,
                    color: Colors.red,
                    indicatorXY: 0.3,
                  ),
                  endChild: Container(
                    constraints: const BoxConstraints(
                      minHeight: 80,
                    ),
                    color: Colors.lightGreenAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Example6Horizontal extends StatelessWidget {
  const Example6Horizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Center(
            child: Container(
              constraints: const BoxConstraints(maxHeight: 100),
              color: Colors.white,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.center,
                    isFirst: true,
                    indicatorStyle: const IndicatorStyle(
                      height: 20,
                      color: Colors.purple,
                      indicatorXY: 0.2,
                      padding: EdgeInsets.all(8),
                    ),
                    startChild: Container(
                      constraints: const BoxConstraints(
                        minWidth: 120,
                      ),
                      color: Colors.amberAccent,
                    ),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.center,
                    indicatorStyle: const IndicatorStyle(
                      height: 10,
                      color: Colors.black,
                      padding: EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 4,
                        right: 4,
                      ),
                    ),
                    startChild: Container(
                      width: 50,
                      color: Colors.purple,
                    ),
                    endChild: Container(
                      color: Colors.cyan,
                    ),
                  ),
                  TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.center,
                    isLast: true,
                    indicatorStyle: const IndicatorStyle(
                      height: 30,
                      color: Colors.red,
                      indicatorXY: 0.3,
                    ),
                    endChild: Container(
                      constraints: const BoxConstraints(
                        minWidth: 80,
                      ),
                      color: Colors.lightGreenAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
