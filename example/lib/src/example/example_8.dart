import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../showcase_timeline.dart';

const example8 = Example(
  name: 'Or provide your own custom indicator.',
  description:
      'With the indicator parameter you can customize the tile with your own '
      'indicator.\nHowever, you must control its size through both width and '
      'height parameters.',
  child: Example8(),
  code: '''
class Example8 extends StatelessWidget {
  const Example8({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TimelineTile(
            alignment: TimelineAlign.right,
            isFirst: true,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 60,
              padding: const EdgeInsets.all(8),
              indicator: Image.asset('assets/example/hitchhiker_2.png'),
            ),
            leftChild: const _Child(
              text: "Don't Panic!",
              font: 'Bungee',
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.right,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              drawGap: true,
              indicator: Container(
                decoration: const BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '42',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            leftChild: const _Child(
              text: 'So long, and thanks',
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.right,
            isLast: true,
            indicatorStyle: IndicatorStyle(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(8),
              indicator: Image.asset('assets/example/hitchhiker.png'),
            ),
            leftChild: const _Child(
              text: 'for all the fish !',
            ),
          ),
        ],
      ),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child({
    Key key,
    this.text,
    this.font = 'Shrikhand',
  }) : super(key: key);

  final String text;
  final String font;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.amberAccent,
      constraints: const BoxConstraints(minHeight: 120),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            font,
            color: Colors.deepOrange,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
};''',
);

class Example8 extends StatelessWidget {
  const Example8({Key key}) : super(key: key);

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
                  alignment: TimelineAlign.right,
                  isFirst: true,
                  indicatorStyle: IndicatorStyle(
                    width: 40,
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    indicator: Image.asset('assets/hitchhiker_2.png'),
                  ),
                  leftChild: const _Child(
                    text: "Don't Panic!",
                    font: 'Bungee',
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.right,
                  indicatorStyle: IndicatorStyle(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    drawGap: true,
                    indicator: Container(
                      decoration: const BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Text(
                          '42',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  leftChild: const _Child(
                    text: 'So long, and thanks',
                  ),
                ),
                TimelineTile(
                  alignment: TimelineAlign.right,
                  isLast: true,
                  indicatorStyle: IndicatorStyle(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    indicator: Image.asset('assets/hitchhiker.png'),
                  ),
                  leftChild: const _Child(
                    text: 'for all the fish !',
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

class _Child extends StatelessWidget {
  const _Child({
    Key key,
    this.text,
    this.font = 'Shrikhand',
  }) : super(key: key);

  final String text;
  final String font;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.amberAccent,
      constraints: const BoxConstraints(minHeight: 120),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            font,
            color: Colors.deepOrange,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}
