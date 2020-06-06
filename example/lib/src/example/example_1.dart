import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';


const example1 = Example(
  name: 'The simplest tile',
  description: 'It aligns default to the left, with a height of 100',
  code: '''
return Container(
  color: Colors.white,
  child: TimelineTile(),
);''',
  child: Example1(),
);

class Example1 extends StatelessWidget {
  const Example1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: TimelineTile(),
          ),
        ],
      ),
    );
  }
}
