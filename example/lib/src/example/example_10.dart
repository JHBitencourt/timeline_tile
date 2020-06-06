import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example10 = Example(
  name: 'Connect tiles with TimelineDivider.',
  description:
  'The TimelineDivider widget allows you to connect tiles that are aligned '
      'in different X axis, when combined with TimelineAlign.manual.',
  child: Example10(),
  code: '''
return Container(
  color: Colors.white,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineX: 0.1,
        isFirst: true,
        indicatorStyle: const IndicatorStyle(
          width: 20,
          color: Colors.purple,
        ),
        topLineStyle: const LineStyle(
          color: Colors.purple,
          width: 6,
        ),
      ),
      const TimelineDivider(
        begin: 0.1,
        end: 0.9,
        thickness: 6,
        color: Colors.purple,
      ),
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineX: 0.9,
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
      const TimelineDivider(
        begin: 0.1,
        end: 0.9,
        thickness: 6,
        color: Colors.deepOrange,
      ),
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineX: 0.1,
        isLast: true,
        topLineStyle: const LineStyle(
          color: Colors.deepOrange,
          width: 6,
        ),
        indicatorStyle: const IndicatorStyle(
          width: 20,
          color: Colors.red,
        ),
      ),
    ],
  ),
);''',
);


class Example10 extends StatelessWidget {
  const Example10({Key key}) : super(key: key);

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
                  lineX: 0.1,
                  isFirst: true,
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.purple,
                  ),
                  topLineStyle: const LineStyle(
                    color: Colors.purple,
                    width: 6,
                  ),
                ),
                const TimelineDivider(
                  begin: 0.1,
                  end: 0.9,
                  thickness: 6,
                  color: Colors.purple,
                ),
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineX: 0.9,
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
                const TimelineDivider(
                  begin: 0.1,
                  end: 0.9,
                  thickness: 6,
                  color: Colors.deepOrange,
                ),
                TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineX: 0.1,
                  isLast: true,
                  topLineStyle: const LineStyle(
                    color: Colors.deepOrange,
                    width: 6,
                  ),
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Colors.red,
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
