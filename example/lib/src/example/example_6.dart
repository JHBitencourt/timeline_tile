import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example6 = Example(
  name: 'Customize the indicator as you wish. ',
  description: 'The default indicator is a circle, and you can customize it '
      'as you wish.\nWith IndicatorStyle you can change the color, the Y '
      'position based on values from 0.0 to 1.0 or give it a padding.\n'
      'You must explicitly provide its width though.',
  child: Example6(),
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
          indicatorY: 0.2,
          padding: EdgeInsets.all(8),
        ),
        leftChild: Container(
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
        leftChild: Container(
          height: 50,
          color: Colors.purple,
        ),
        rightChild: Container(
          color: Colors.cyan,
        ),
      ),
      TimelineTile(
        alignment: TimelineAlign.center,
        isLast: true,
        indicatorStyle: const IndicatorStyle(
          width: 30,
          color: Colors.red,
          indicatorY: 0.3,
        ),
        rightChild: Container(
          constraints: const BoxConstraints(
            minHeight: 80,
          ),
          color: Colors.lightGreenAccent,
        ),
      ),
    ],
  ),
);''',
);

class Example6 extends StatelessWidget {
  const Example6({Key key}) : super(key: key);

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
                    indicatorY: 0.2,
                    padding: EdgeInsets.all(8),
                  ),
                  leftChild: Container(
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
                  leftChild: Container(
                    height: 50,
                    color: Colors.purple,
                  ),
                  rightChild: Container(
                    color: Colors.cyan,
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.center,
                  isLast: true,
                  indicatorStyle: const IndicatorStyle(
                    width: 30,
                    color: Colors.red,
                    indicatorY: 0.3,
                  ),
                  rightChild: Container(
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
