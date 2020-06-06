import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example3 = Example(
  name: 'Manual aligning the indicator',
  description:
      'With TimelineAlign.manual you can provide the lineX, which allows you to'
      'specify a value from 0.0 to 1.0, that represents a widht percentage. '
      'For example, aligning at 30% of the widht:',
  child: Example3(),
  code: '''
return Container(
  color: Colors.white,
  child: TimelineTile(
    alignment: TimelineAlign.manual,
    lineX: 0.3,
    rightChild: Container(
      constraints: const BoxConstraints(
        minHeight: 120,
      ),
      color: Colors.lightGreenAccent,
    ),
    leftChild: Container(
      color: Colors.amberAccent,
    ),
  ),
);''',
);

class Example3 extends StatelessWidget {
  const Example3({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              lineX: 0.3,
              rightChild: Container(
                constraints: const BoxConstraints(
                  minHeight: 120,
                ),
                color: Colors.lightGreenAccent,
              ),
              leftChild: Container(
                color: Colors.amberAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
