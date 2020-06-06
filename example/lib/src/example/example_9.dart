import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example9 = Example(
  name: "Customize the tile's line.",
  description:
      'With LineStyle you can customize both topLine and bottomLine.',
  child: Example9(),
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
        ),
        topLineStyle: const LineStyle(
          color: Colors.purple,
          width: 6,
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
        topLineStyle: const LineStyle(
          color: Colors.purple,
          width: 6,
        ),
        bottomLineStyle: const LineStyle(
          color: Colors.deepOrange,
          width: 6,
        ),
        indicatorStyle: const IndicatorStyle(
          width: 20,
          color: Colors.cyan,
        ),
      ),
      TimelineTile(
        alignment: TimelineAlign.center,
        isLast: true,
        topLineStyle: const LineStyle(
          color: Colors.deepOrange,
          width: 6,
        ),
        indicatorStyle: const IndicatorStyle(
          width: 20,
          color: Colors.red,
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


class Example9 extends StatelessWidget {
  const Example9({Key key}) : super(key: key);

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
                  ),
                  topLineStyle: const LineStyle(
                    color: Colors.purple,
                    width: 6,
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
                  topLineStyle: const LineStyle(
                    color: Colors.purple,
                    width: 6,
                  ),
                  bottomLineStyle: const LineStyle(
                    color: Colors.deepOrange,
                    width: 6,
                  ),
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.cyan,
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.center,
                  isLast: true,
                  topLineStyle: const LineStyle(
                    color: Colors.deepOrange,
                    width: 6,
                  ),
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.red,
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
