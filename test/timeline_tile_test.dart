import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:timeline_tile/timeline_tile.dart';

Future<void> pumpTimeline(WidgetTester tester, TimelineTile timeline) async {
  return await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: timeline,
    ),
  );
}

void main() {
  testWidgets(
    'Creates a default tile with a default indicator aligned to the left',
    (WidgetTester tester) async {
      await pumpTimeline(tester, TimelineTile());

      final finderTimeline = find.byType(TimelineTile);
      final timeline = tester.widget(finderTimeline);
      expect(
          timeline,
          isA<TimelineTile>().having(
              (t) => t.alignment, 'Aligned to the left', TimelineAlign.start));
      expect(
          timeline,
          isA<TimelineTile>()
              .having((t) => t.hasIndicator, 'With an indicator', true));

      /// The default indicator style
      expect(
          timeline,
          isA<TimelineTile>().having((t) => t.indicatorStyle.width,
              'Default indicator with a widht of 25', 25));
      expect(
          timeline,
          isA<TimelineTile>().having((t) => t.indicatorStyle.height,
              'Default indicator with a height of 20', 20));
      expect(
          timeline,
          isA<TimelineTile>().having((t) => t.indicatorStyle.color,
              'Default indicator with a grey color', Colors.grey));
      expect(
          timeline,
          isA<TimelineTile>().having((t) => t.indicatorStyle.indicatorXY,
              'Default indicator positioned at the y center', 0.5));
      expect(
          timeline,
          isA<TimelineTile>().having((t) => t.indicatorStyle.padding,
              'Default indicator without padding', const EdgeInsets.all(0)));
      expect(
          timeline,
          isA<TimelineTile>().having((t) => t.indicatorStyle.iconStyle,
              'Default indicator without icon', null));

      /// The default line style
      expect(
          timeline,
          isA<TimelineTile>().having((t) => t.beforeLineStyle.color,
              'Default line with a grey color', Colors.grey));
      expect(
          timeline,
          isA<TimelineTile>().having((t) => t.beforeLineStyle.thickness,
              'Default indicator with a widht of 4', 4));

      final finderRow = find.byType(Row);
      expect(finderRow, findsOneWidget);
      expect(
          tester.widget(finderRow),
          isA<Row>()
              .having((Row r) => r.children.length, 'With two children', 2));
      expect(
          tester.widget(finderRow),
          isA<Row>().having((Row r) => r.children.last,
              "Last in the row is the timeline's child", isA<Expanded>()));
    },
  );

  Widget buildTimelineTile(TimelineTile tile,
      {double width = 400, double height = 100}) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RepaintBoundary(
          child: Container(
            width: width,
            height: height,
            color: Colors.white,
            child: tile,
          ),
        ),
      ),
    );
  }

  Widget buildTimelineAlignedLeftWithHorizontalPaddingAndGreenChild() {
    return buildTimelineTile(
      TimelineTile(
        indicatorStyle: const IndicatorStyle(
          width: 25,
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
        endChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline aligned to the left with padding and green child',
    (WidgetTester tester) async {
      final widget =
          buildTimelineAlignedLeftWithHorizontalPaddingAndGreenChild();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineAlignedLeftWithHorizontalPaddingAndGreenChild.png'),
      );
    },
  );

  Widget buildHorizontalTimelineAlignedStartWithVerticalPaddingAndGreenChild() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        indicatorStyle: const IndicatorStyle(
          height: 25,
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        endChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline aligned to the left with padding and green child',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineAlignedStartWithVerticalPaddingAndGreenChild();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineAlignedStartWithVerticalPaddingAndGreenChild.png'),
      );
    },
  );

  Widget buildTimelineAlignedRightWithHorizontalPaddingAndGreenChild() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.end,
        indicatorStyle: const IndicatorStyle(
          width: 25,
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline aligned to the right with padding and green child',
    (WidgetTester tester) async {
      final widget =
          buildTimelineAlignedRightWithHorizontalPaddingAndGreenChild();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineAlignedRightWithHorizontalPaddingAndGreenChild.png'),
      );
    },
  );

  Widget buildHorizontalTimelineAlignedEndWithHorizontalPaddingAndGreenChild() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.end,
        indicatorStyle: const IndicatorStyle(
          height: 25,
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline aligned to the end with padding and green child',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineAlignedEndWithHorizontalPaddingAndGreenChild();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineAlignedEndWithHorizontalPaddingAndGreenChild.png'),
      );
    },
  );

  Widget buildTimelineAlignedCenterWithHorizontalPaddingAndGreenChildren() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          width: 25,
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline aligned to the center with padding and both children green',
    (WidgetTester tester) async {
      final widget =
          buildTimelineAlignedCenterWithHorizontalPaddingAndGreenChildren();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineAlignedCenterWithHorizontalPaddingAndGreenChildren.png'),
      );
    },
  );

  Widget
      buildHorizontalTimelineAlignedCenterWithVerticalPaddingAndGreenChildren() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          height: 25,
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline aligned to the center with padding and both children green',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineAlignedCenterWithVerticalPaddingAndGreenChildren();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineAlignedCenterWithVerticalPaddingAndGreenChildren.png'),
      );
    },
  );

  Widget
      buildTimelineAlignedManual30PercentWithHorizontalPaddingAndGreenChildren() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.3,
        indicatorStyle: const IndicatorStyle(
          width: 25,
          padding: EdgeInsets.symmetric(horizontal: 10),
        ),
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline aligned manual at 30% with padding and both children green',
    (WidgetTester tester) async {
      final widget =
          buildTimelineAlignedManual30PercentWithHorizontalPaddingAndGreenChildren();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineAlignedManual30PercentWithHorizontalPaddingAndGreenChildren.png'),
      );
    },
  );

  Widget
      buildHorizontalTimelineAlignedManual30PercentWithVerticalPaddingAndGreenChildren() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.manual,
        lineXY: 0.3,
        indicatorStyle: const IndicatorStyle(
          height: 25,
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline aligned manual at 30% with padding and both children green',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineAlignedManual30PercentWithVerticalPaddingAndGreenChildren();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineAlignedManual30PercentWithVerticalPaddingAndGreenChildren.png'),
      );
    },
  );

  Widget
      buildTimelineFirstWithIndicatorAlignedAt70PercentYAndVerticalPadding() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          width: 25,
          padding: EdgeInsets.all(4),
          indicatorXY: 0.7,
        ),
        isFirst: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline first with indicator aligned at 70% Y and vertical padding',
    (WidgetTester tester) async {
      final widget =
          buildTimelineFirstWithIndicatorAlignedAt70PercentYAndVerticalPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineFirstWithIndicatorAlignedAt70PercentYAndVerticalPadding.png'),
      );
    },
  );

  Widget
      buildHorizontalTimelineFirstWithIndicatorAlignedAt70PercentXAndHorizontalPadding() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          height: 25,
          padding: EdgeInsets.all(4),
          indicatorXY: 0.7,
        ),
        isFirst: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline first with indicator aligned at 70% X and horizontal padding',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineFirstWithIndicatorAlignedAt70PercentXAndHorizontalPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineFirstWithIndicatorAlignedAt70PercentXAndHorizontalPadding.png'),
      );
    },
  );

  Widget buildTimelineLastWithCustomIndicatorAndVerticalPadding() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 40,
          indicator: Container(
            color: Colors.orange,
            child: Center(
              child: Container(
                height: 20,
                width: 20,
                color: Colors.blue,
              ),
            ),
          ),
          padding: const EdgeInsets.all(8),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline last with custom indicator and vertical padding',
    (WidgetTester tester) async {
      final widget = buildTimelineLastWithCustomIndicatorAndVerticalPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineLastWithCustomIndicatorAndVerticalPadding.png'),
      );
    },
  );

  Widget buildHorizontalTimelineLastWithCustomIndicatorAndHorizontalPadding() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 40,
          indicator: Container(
            color: Colors.orange,
            child: Center(
              child: Container(
                height: 20,
                width: 20,
                color: Colors.blue,
              ),
            ),
          ),
          padding: const EdgeInsets.all(8),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline last with custom indicator and vertical padding',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineLastWithCustomIndicatorAndHorizontalPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineLastWithCustomIndicatorAndHorizontalPadding.png'),
      );
    },
  );

  Widget buildTimelineFirstAndLastWithDefaultIconIndicator() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          width: 40,
          iconStyle: IconStyle(iconData: Icons.close, color: Colors.blue),
          padding: const EdgeInsets.all(8),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline first and last with default icon indicator',
    (WidgetTester tester) async {
      final widget = buildTimelineFirstAndLastWithDefaultIconIndicator();
      await tester.pumpWidget(widget);

      /// Since golden images don't render texts, the result won't be accurate
      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineFirstAndLastWithDefaultIconIndicator.png'),
      );
    },
  );

  Widget buildHorizontalTimelineFirstAndLastWithDefaultIconIndicator() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          height: 40,
          iconStyle: IconStyle(iconData: Icons.close, color: Colors.blue),
          padding: const EdgeInsets.all(8),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline first and last with default icon indicator',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineFirstAndLastWithDefaultIconIndicator();
      await tester.pumpWidget(widget);

      /// Since golden images don't render texts, the result won't be accurate
      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineFirstAndLastWithDefaultIconIndicator.png'),
      );
    },
  );

  Widget buildTimelineWithCustomLineSizeAndColorWithoutIndicator() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        beforeLineStyle: const LineStyle(
          color: Colors.lightBlue,
          thickness: 8,
        ),
        hasIndicator: false,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline with custom line size and color',
    (WidgetTester tester) async {
      final widget = buildTimelineWithCustomLineSizeAndColorWithoutIndicator();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineWithCustomLineSizeAndColorWithoutIndicator.png'),
      );
    },
  );

  Widget buildHorizontalTimelineWithCustomLineSizeAndColorWithoutIndicator() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        beforeLineStyle: const LineStyle(
          color: Colors.lightBlue,
          thickness: 8,
        ),
        hasIndicator: false,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline with custom line size and color',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineWithCustomLineSizeAndColorWithoutIndicator();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineWithCustomLineSizeAndColorWithoutIndicator.png'),
      );
    },
  );

  Widget buildTimelineWithCustomTopLineAndBottomLine() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        beforeLineStyle: const LineStyle(
          color: Colors.lightBlue,
          thickness: 8,
        ),
        afterLineStyle: const LineStyle(
          color: Colors.orange,
          thickness: 12,
        ),
        hasIndicator: false,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline with custom top line and bottom line',
    (WidgetTester tester) async {
      final widget = buildTimelineWithCustomTopLineAndBottomLine();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile('golden/timelineWithCustomTopLineAndBottomLine.png'),
      );
    },
  );

  Widget buildHorizontalTimelineWithCustomBeforeLineAndAfterLine() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        beforeLineStyle: const LineStyle(
          color: Colors.lightBlue,
          thickness: 8,
        ),
        afterLineStyle: const LineStyle(
          color: Colors.orange,
          thickness: 12,
        ),
        hasIndicator: false,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline with custom before and after lines',
    (WidgetTester tester) async {
      final widget = buildHorizontalTimelineWithCustomBeforeLineAndAfterLine();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineWithCustomBeforeLineAndAfterLine.png'),
      );
    },
  );

  Widget buildTimelineWithCustomTopLineAndBottomLineAndGap() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        beforeLineStyle: const LineStyle(
          color: Colors.lightBlue,
          thickness: 8,
        ),
        afterLineStyle: const LineStyle(
          color: Colors.orange,
          thickness: 12,
        ),
        indicatorStyle: const IndicatorStyle(
          width: 20,
          padding: EdgeInsets.only(top: 5, bottom: 10),
        ),
        hasIndicator: false,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline with custom top line, bottom line and gap',
    (WidgetTester tester) async {
      final widget = buildTimelineWithCustomTopLineAndBottomLineAndGap();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineWithCustomTopLineAndBottomLineAndGap.png'),
      );
    },
  );

  Widget buildHorizontalTimelineWithCustomBeforeLineAndAfterLineAndGap() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        beforeLineStyle: const LineStyle(
          color: Colors.lightBlue,
          thickness: 8,
        ),
        afterLineStyle: const LineStyle(
          color: Colors.orange,
          thickness: 12,
        ),
        indicatorStyle: const IndicatorStyle(
          height: 20,
          padding: EdgeInsets.only(left: 5, right: 10),
        ),
        hasIndicator: false,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline with custom before line, start line and gap',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineWithCustomBeforeLineAndAfterLineAndGap();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineWithCustomBeforeLineAndAfterLineAndGap.png'),
      );
    },
  );

  Widget buildTimelineWithCustomIndicatorExceedingTileSizeWithPadding() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 120,
          indicator: Container(
            color: Colors.orange,
            child: Center(
              child: Container(
                height: 110,
                width: 20,
                color: Colors.blue,
              ),
            ),
          ),
          padding: const EdgeInsets.only(top: 10, bottom: 4),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline with custom indicator exceeding tile size',
    (WidgetTester tester) async {
      final widget =
          buildTimelineWithCustomIndicatorExceedingTileSizeWithPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineWithCustomIndicatorExceedingTileSizeWithPadding.png'),
      );
    },
  );

  Widget
      buildHorizontalTimelineWithCustomIndicatorExceedingTileSizeWithPadding() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          width: 420,
          height: 40,
          indicator: Container(
            color: Colors.orange,
            child: Center(
              child: Container(
                height: 20,
                width: 410,
                color: Colors.blue,
              ),
            ),
          ),
          padding: const EdgeInsets.only(left: 10, right: 4),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline with custom indicator exceeding tile size',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineWithCustomIndicatorExceedingTileSizeWithPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineWithCustomIndicatorExceedingTileSizeWithPadding.png'),
      );
    },
  );

  Widget buildTimelineWithCustomIndicatorExceedingTileSizeWithoutPadding() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 120,
          indicator: Container(
            color: Colors.orange,
            child: Center(
              child: Container(
                height: 110,
                width: 20,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline with custom indicator exceeding tile size',
    (WidgetTester tester) async {
      final widget =
          buildTimelineWithCustomIndicatorExceedingTileSizeWithoutPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineWithCustomIndicatorExceedingTileSizeWithoutPadding.png'),
      );
    },
  );

  Widget
      buildHorizontalTimelineWithCustomIndicatorExceedingTileSizeWithoutPadding() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          width: 420,
          height: 40,
          indicator: Container(
            color: Colors.orange,
            child: Center(
              child: Container(
                height: 20,
                width: 410,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline with custom indicator exceeding tile size',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineWithCustomIndicatorExceedingTileSizeWithoutPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineWithCustomIndicatorExceedingTileSizeWithoutPadding.png'),
      );
    },
  );

  Widget buildTimelineWithCustomIndicatorExceedingSizeAtTheBottom() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 40,
          indicatorXY: 1,
          indicator: Container(
            color: Colors.orange,
            child: Center(
              child: Container(
                height: 40,
                width: 40,
                color: Colors.blue,
              ),
            ),
          ),
          padding: const EdgeInsets.all(8),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline with custom indicator exceeding size at the bottom',
    (WidgetTester tester) async {
      final widget = buildTimelineWithCustomIndicatorExceedingSizeAtTheBottom();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineWithCustomIndicatorExceedingSizeAtTheBottom.png'),
      );
    },
  );

  Widget buildHorizontalTimelineWithCustomIndicatorExceedingSizeAtTheEnd() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: IndicatorStyle(
          width: 40,
          height: 40,
          indicatorXY: 1,
          indicator: Container(
            color: Colors.orange,
            child: Center(
              child: Container(
                height: 40,
                width: 40,
                color: Colors.blue,
              ),
            ),
          ),
          padding: const EdgeInsets.all(8),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal Timeline with custom indicator exceeding size at the end',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineWithCustomIndicatorExceedingSizeAtTheEnd();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineWithCustomIndicatorExceedingSizeAtTheEnd.png'),
      );
    },
  );

  Widget buildTimelineWithDefaultIndicatorExceedingSizeAtTheBottom() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          width: 40,
          height: 40,
          indicatorXY: 1,
          padding: EdgeInsets.all(8),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline with default indicator exceeding size at the bottom',
    (WidgetTester tester) async {
      final widget =
          buildTimelineWithDefaultIndicatorExceedingSizeAtTheBottom();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineWithDefaultIndicatorExceedingSizeAtTheBottom.png'),
      );
    },
  );

  Widget buildHorizontalTimelineWithDefaultIndicatorExceedingSizeAtTheEnd() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          width: 40,
          height: 40,
          indicatorXY: 1,
          padding: EdgeInsets.all(8),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline with default indicator exceeding size at the end',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineWithDefaultIndicatorExceedingSizeAtTheEnd();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineWithDefaultIndicatorExceedingSizeAtTheEnd.png'),
      );
    },
  );

  Widget buildTimelineWithDefaultIndicatorExceedingTileSizeWithPadding() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          width: 120,
          height: 120,
          padding: EdgeInsets.only(top: 10, bottom: 4),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline with default indicator exceeding tile size',
    (WidgetTester tester) async {
      final widget =
          buildTimelineWithDefaultIndicatorExceedingTileSizeWithPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineWithDefaultIndicatorExceedingTileSizeWithPadding.png'),
      );
    },
  );

  Widget
      buildHorizontalTimelineWithDefaultIndicatorExceedingTileSizeWithPadding() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          width: 120,
          height: 120,
          padding: EdgeInsets.only(left: 10, right: 4),
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
      width: 100,
      height: 400,
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline with default indicator exceeding tile size',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineWithDefaultIndicatorExceedingTileSizeWithPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineWithDefaultIndicatorExceedingTileSizeWithPadding.png'),
      );
    },
  );

  Widget buildTimelineWithDefaultIndicatorExceedingTileSizeWithoutPadding() {
    return buildTimelineTile(
      TimelineTile(
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          width: 120,
          height: 120,
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
    );
  }

  testWidgets(
    'GoldenTest - Timeline with default indicator exceeding tile size',
    (WidgetTester tester) async {
      final widget =
          buildTimelineWithDefaultIndicatorExceedingTileSizeWithoutPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/timelineWithDefaultIndicatorExceedingTileSizeWithoutPadding.png'),
      );
    },
  );

  Widget
      buildHorizontalTimelineWithDefaultIndicatorExceedingTileSizeWithoutPadding() {
    return buildTimelineTile(
      TimelineTile(
        axis: TimelineAxis.horizontal,
        alignment: TimelineAlign.center,
        indicatorStyle: const IndicatorStyle(
          width: 120,
          height: 120,
        ),
        isLast: true,
        endChild: Container(color: Colors.green),
        startChild: Container(color: Colors.green),
      ),
      width: 100,
      height: 400,
    );
  }

  testWidgets(
    'GoldenTest - Horizontal timeline with default indicator exceeding tile size without padding',
    (WidgetTester tester) async {
      final widget =
          buildHorizontalTimelineWithDefaultIndicatorExceedingTileSizeWithoutPadding();
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(TimelineTile),
        matchesGoldenFile(
            'golden/horizontalTimelineWithDefaultIndicatorExceedingTileSizeWithoutPadding.png'),
      );
    },
  );
}
