import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example3 = Example(
  name: 'Manual aligning the indicator',
  description:
      'With TimelineAlign.manual you can provide the lineXY, which allows you to'
      'specify a value from 0.0 to 1.0, that represents a width/height percentage. '
      'For example, aligning at 0.3(30%) of the width/height:',
  code: '''
return Container(
  color: Colors.white,
  child: TimelineTile(
    alignment: TimelineAlign.manual,
    lineXY: 0.3,
    startChild: Container(
      constraints: const BoxConstraints(
        minHeight: 120,
      ),
      color: Colors.lightGreenAccent,
    ),
    endChild: Container(
      color: Colors.amberAccent,
    ),
  ),
);''',
  childVertical: Example3Vertical(),
  childHorizontal: Example3Horizontal(),
);

class Example3Vertical extends StatelessWidget {
  const Example3Vertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: TimelineTile(
              alignment: TimelineAlign.manual,
              lineXY: 0.3,
              startChild: Container(
                constraints: const BoxConstraints(
                  minHeight: 120,
                ),
                color: Colors.lightGreenAccent,
              ),
              endChild: Container(
                color: Colors.amberAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Example3Horizontal extends StatelessWidget {
  const Example3Horizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Row(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 100),
                color: Colors.white,
                child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.manual,
                  lineXY: 0.3,
                  startChild: Container(
                    constraints: const BoxConstraints(
                      minWidth: 120,
                    ),
                    color: Colors.lightGreenAccent,
                  ),
                  endChild: Container(
                    color: Colors.amberAccent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
