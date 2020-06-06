import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example4 = Example(
  name: 'Is it the first or the last?',
  description:
      'You can decide if a tile is the first os the last in a timeline. '
      'This way you control whether a top or bottom line must be rendered.',
  child: Example4(),
  code: '''
return Container(
  color: Colors.white,
  child: TimelineTile(
    alignment: TimelineAlign.right,
    isFirst: true,
    leftChild: Container(
      constraints: const BoxConstraints(
        minHeight: 120,
      ),
      color: Colors.amberAccent,
    ),
  ),
);''',
);

class Example4 extends StatelessWidget {
  const Example4({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: TimelineTile(
              alignment: TimelineAlign.right,
              isFirst: true,
              leftChild: Container(
                constraints: const BoxConstraints(
                  minHeight: 120,
                ),
                color: Colors.amberAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
