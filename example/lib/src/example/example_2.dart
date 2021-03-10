import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example2 = Example(
  name: 'A centered tile with children',
  description: 'With TimelineAlign.center you can configure both start and end '
      'children. But when providing children to the tile the height (axis vertical) '
      'or the width (axis horizontal) will be as minimum as possible, so you can '
      'control it with a height/width constraint (at least minHeight/minWidth). '
      'This way the tile knows how to size it properly.',
  code: '''
return Container(
    color: Colors.white,
    child: TimelineTile(
      alignment: TimelineAlign.center,
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
);''',
  childVertical: Example2Vertical(),
  childHorizontal: Example2Horizontal(),
);

class Example2Vertical extends StatelessWidget {
  const Example2Vertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: TimelineTile(
              alignment: TimelineAlign.center,
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

class Example2Horizontal extends StatelessWidget {
  const Example2Horizontal({Key? key}) : super(key: key);

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
                  alignment: TimelineAlign.center,
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
