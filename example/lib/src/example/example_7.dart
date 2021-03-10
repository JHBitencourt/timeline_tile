import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example7 = Example(
  name: 'Give an Icon to the indicator.',
  description: 'With IconStyle you can provide an Icon to be rendered inside '
      'the default indicator.',
  code: '''
return Container(
  color: Colors.white,
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      TimelineTile(
        alignment: TimelineAlign.center,
        isFirst: true,
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: Colors.purple,
          padding: const EdgeInsets.all(8),
          iconStyle: IconStyle(
            color: Colors.white,
            iconData: Icons.insert_emoticon,
          ),
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
        isLast: true,
        indicatorStyle: IndicatorStyle(
          width: 30,
          color: Colors.red,
          indicatorXY: 0.7,
          iconStyle: IconStyle(
            color: Colors.white,
            iconData: Icons.thumb_up,
          ),
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
  childVertical: Example7Vertical(),
  childHorizontal: Example7Horizontal(),
);

class Example7Vertical extends StatelessWidget {
  const Example7Vertical({Key? key}) : super(key: key);

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
                  indicatorStyle: IndicatorStyle(
                    width: 40,
                    color: Colors.purple,
                    padding: const EdgeInsets.all(8),
                    iconStyle: IconStyle(
                      color: Colors.white,
                      iconData: Icons.insert_emoticon,
                    ),
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
                  isLast: true,
                  indicatorStyle: IndicatorStyle(
                    width: 30,
                    color: Colors.red,
                    indicatorXY: 0.7,
                    iconStyle: IconStyle(
                      color: Colors.white,
                      iconData: Icons.thumb_up,
                    ),
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

class Example7Horizontal extends StatelessWidget {
  const Example7Horizontal({Key? key}) : super(key: key);

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
                    indicatorStyle: IndicatorStyle(
                      height: 40,
                      color: Colors.purple,
                      padding: const EdgeInsets.all(8),
                      iconStyle: IconStyle(
                        color: Colors.white,
                        iconData: Icons.insert_emoticon,
                      ),
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
                    isLast: true,
                    indicatorStyle: IndicatorStyle(
                      height: 30,
                      color: Colors.red,
                      indicatorXY: 0.7,
                      iconStyle: IconStyle(
                        color: Colors.white,
                        iconData: Icons.thumb_up,
                      ),
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
