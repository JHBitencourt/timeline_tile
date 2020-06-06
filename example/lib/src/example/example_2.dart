import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example2 = Example(
  name: 'A centered tile with children',
  description:
      'With TimelineAlign.center you can configure both left and right '
      'children. But when providing children to the tile the height will '
      'be as minimum as possible, so you can control it with a height '
      'constraint (at least minHeight). This way the tile knows how to size '
      'it properly.',
  child: Example2(),
  code: '''
return Container(
    color: Colors.white,
    child: TimelineTile(
      alignment: TimelineAlign.center,
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
);''',
);

class Example2 extends StatelessWidget {
  const Example2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: TimelineTile(
              alignment: TimelineAlign.center,
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
