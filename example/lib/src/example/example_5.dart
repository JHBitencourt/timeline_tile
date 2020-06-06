import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example5 = Example(
  name: 'Start to make a timeline!!',
  description: 'You can finally start to combine some tiles to make a Timeline.'
      ' The flag hasIndicator can control whether an indicator should or'
      " shouldn't be rendered.",
  child: Example5(),
  code: '''
return Container(
  color: Colors.white,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineX: 0.7,
        isFirst: true,
        leftChild: Container(
          constraints: const BoxConstraints(
            minHeight: 120,
          ),
          color: Colors.amberAccent,
        ),
      ),
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineX: 0.7,
        hasIndicator: false,
        leftChild: Container(
          height: 50,
          color: Colors.purple,
        ),
        rightChild: Container(
          color: Colors.cyan,
        ),
      ),
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineX: 0.7,
        isLast: true,
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

class Example5 extends StatelessWidget {
  const Example5({Key key}) : super(key: key);

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
                  alignment: TimelineAlign.manual,
                  lineX: 0.7,
                  isFirst: true,
                  leftChild: Container(
                    constraints: const BoxConstraints(
                      minHeight: 120,
                    ),
                    color: Colors.amberAccent,
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineX: 0.7,
                  hasIndicator: false,
                  leftChild: Container(
                    height: 50,
                    color: Colors.purple,
                  ),
                  rightChild: Container(
                    color: Colors.cyan,
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineX: 0.7,
                  isLast: true,
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
