import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:timeline_tile/src/axis.dart';
import 'package:timeline_tile/src/style.dart';

/// The alignment used on the [TimelineTile].
enum TimelineAlign {
  /// Automatically align the line to the left, only the ([TimelineTile.rightChild])
  /// will be available.
  left,

  /// Automatically align the line to the right, only the ([TimelineTile.leftChild])
  /// will be available.
  right,

  /// Automatically align the line to the center, both ([TimelineTile.leftChild])
  /// and ([TimelineTile.rightChild]) will be available.
  center,

  /// Indicates that the line will be aligned manually and must be used with ([TimelineTile.lineX]),
  /// both ([TimelineTile.leftChild]) and ([TimelineTile.rightChild]) will be available
  /// depending on the free space.
  manual,
}

/// A tile that renders a timeline format.
class TimelineTile extends StatelessWidget {
  const TimelineTile({
    Key key,
    this.alignment = TimelineAlign.left,
    this.rightChild,
    this.leftChild,
    this.lineX,
    this.hasIndicator = true,
    this.isFirst = false,
    this.isLast = false,
    this.indicatorStyle = const IndicatorStyle(width: 25),
    this.topLineStyle = const LineStyle(),
    LineStyle bottomLineStyle,
  })  : bottomLineStyle = bottomLineStyle ?? topLineStyle,
        assert(alignment != TimelineAlign.left || leftChild == null,
            'Cannot provide leftChild with automatic alignment to the left'),
        assert(alignment != TimelineAlign.right || rightChild == null,
            'Cannot provide rightChild with automatic alignment to the right'),
        assert(
            alignment != TimelineAlign.manual ||
                (lineX != null && lineX >= 0.0 && lineX <= 1.0),
            'The lineX must be provided when aligning manually, '
            'and must be a value between 0.0 and 1.0 inclusive'),
        super(key: key);

  /// The alignment used on the line. See [TimelineAlign].
  final TimelineAlign alignment;

  /// The child widget positioned at the right
  final Widget rightChild;

  /// The child widget positioned at the left
  final Widget leftChild;

  /// The X axis value used to position the line when [TimelineAlign.manual].
  /// Must be a value from 0.0 to 1.0
  final double lineX;

  /// Whether it should have an indicator (default or custom).
  /// It defaults to true.
  final bool hasIndicator;

  /// Whether this is the first tile from the timeline.
  /// In this case, it won't be rendered a line above the indicator.
  final bool isFirst;

  /// Whether this is the last tile from the timeline.
  /// In this case, it won't be rendered a line bellow the indicator.
  final bool isLast;

  /// The style used to customize the indicator.
  final IndicatorStyle indicatorStyle;

  /// The style used to customize the top line.
  final LineStyle topLineStyle;

  /// The style used to customize the bottom line.
  /// If null, it defaults to [topLineStyle].
  final LineStyle bottomLineStyle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final children = <Widget>[
          if (indicatorStyle.padding.left > 0)
            SizedBox(width: indicatorStyle.padding.left),
          _Indicator(
            topLineStyle: topLineStyle,
            bottomLineStyle: bottomLineStyle ?? topLineStyle,
            indicatorStyle: indicatorStyle,
            hasIndicator: hasIndicator,
            isLast: isLast,
            isFirst: isFirst,
          ),
          if (indicatorStyle.padding.right > 0)
            SizedBox(width: indicatorStyle.padding.right),
        ];

        final defaultChild = Container(height: 100);
        if (alignment == TimelineAlign.left) {
          children.add(Expanded(child: rightChild ?? defaultChild));
        } else if (alignment == TimelineAlign.right) {
          children.insert(0, Expanded(child: leftChild ?? defaultChild));
        } else {
          final double indicatorAxisX =
              alignment == TimelineAlign.center ? 0.5 : lineX;
          final indicatorTotalSize = indicatorStyle.padding.left +
              indicatorStyle.padding.right +
              (hasIndicator
                  ? indicatorStyle.width
                  : max(topLineStyle.width, bottomLineStyle.width));

          final positioning = calculateAxisPositioning(
            totalSize: constraints.maxWidth,
            objectSize: indicatorTotalSize,
            axisPosition: indicatorAxisX,
          );

          if (positioning.firstSpace.size > 0) {
            children.insert(
              0,
              SizedBox(
                width: positioning.firstSpace.size,
                child: leftChild ?? defaultChild,
              ),
            );
          }

          if (positioning.secondSpace.size > 0) {
            children.add(
              SizedBox(
                width: positioning.secondSpace.size,
                child: rightChild ?? defaultChild,
              ),
            );
          }
        }

        return IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: children,
          ),
        );
      },
    );
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    this.topLineStyle,
    this.bottomLineStyle,
    this.indicatorStyle,
    this.hasIndicator,
    this.isFirst,
    this.isLast,
  });

  /// See [(TimelineTile.topLineStyle)]
  final LineStyle topLineStyle;

  /// See [(TimelineTile.bottomLineStyle)]
  final LineStyle bottomLineStyle;

  /// See [(TimelineTile.indicatorStyle)]
  final IndicatorStyle indicatorStyle;

  /// See [(TimelineTile.hasIndicator)]
  final bool hasIndicator;

  /// See [(TimelineTile.isFirst)]
  final bool isFirst;

  /// See [(TimelineTile.isLast)]
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final childrenStack = <Widget>[
      SizedBox(
        width: hasIndicator
            ? indicatorStyle.width
            : max(topLineStyle.width, bottomLineStyle.width),
        height: double.infinity,
      )
    ];

    final renderDefaultlIndicator =
        hasIndicator && indicatorStyle.indicator == null;
    if (!renderDefaultlIndicator) {
      childrenStack.add(
        _buildCustomIndicator(),
      );
    }

    final painter = _TimelinePainter(
      topLineStyle: topLineStyle,
      bottomLineStyle: bottomLineStyle,
      indicatorStyle: indicatorStyle,
      paintIndicator: renderDefaultlIndicator,
      isFirst: isFirst,
      isLast: isLast,
    );

    return CustomPaint(
      painter: painter,
      child: Stack(
        children: childrenStack,
      ),
    );
  }

  Widget _buildCustomIndicator() {
    return Positioned.fill(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final positioning = calculateAxisPositioning(
            totalSize: constraints.maxHeight,
            objectSize: indicatorStyle.totalHeight,
            axisPosition: indicatorStyle.indicatorY,
          );

          return Padding(
            padding: EdgeInsets.only(
              top: positioning.firstSpace.size,
              bottom: positioning.secondSpace.size,
            ),
            child: SizedBox(
              height: positioning.objectSpace.size,
              width: indicatorStyle.width,
              child: Center(
                child: SizedBox(
                  height: indicatorStyle.height,
                  width: indicatorStyle.width,
                  child: indicatorStyle.indicator,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A custom painter that renders a line and an indicator
class _TimelinePainter extends CustomPainter {
  _TimelinePainter({
    this.paintIndicator = true,
    this.isFirst = false,
    this.isLast = false,
    IndicatorStyle indicatorStyle,
    LineStyle topLineStyle,
    LineStyle bottomLineStyle,
  })  : topLinePaint = Paint()
          ..color = topLineStyle.color
          ..strokeWidth = topLineStyle.width,
        bottomLinePaint = Paint()
          ..color = bottomLineStyle.color
          ..strokeWidth = bottomLineStyle.width,
        indicatorPaint =
            !paintIndicator ? null : (Paint()..color = indicatorStyle.color),
        indicatorY = indicatorStyle.indicatorY,
        indicatorRadius = indicatorStyle.width / 2,
        indicatorHeight = paintIndicator
            ? indicatorStyle.width
            : (indicatorStyle.indicator != null ? indicatorStyle.height : 0),
        indicatorTopGap = indicatorStyle.padding.top,
        indicatorBottomGap = indicatorStyle.padding.bottom,
        drawGap = indicatorStyle.drawGap,
        iconData = indicatorStyle.iconStyle != null
            ? indicatorStyle.iconStyle.iconData
            : null,
        iconColor = indicatorStyle.iconStyle != null
            ? indicatorStyle.iconStyle.color
            : null,
        iconSize = indicatorStyle.iconStyle != null
            ? indicatorStyle.iconStyle.fontSize
            : null;

  /// Value from 0.0 to 1.0 indicating the percentage in which the indicator
  /// should be positioned on the line, starting from the top.
  /// For example, 0.2 means 20% from top to bottom.
  final double indicatorY;

  /// A gap/space between the line and the indicator
  final double indicatorTopGap;

  /// A gap/space between the line and the indicator
  final double indicatorBottomGap;

  /// The radius from the default indicator
  final double indicatorRadius;

  /// The height from the indicator. If it is the default indicator, the height
  /// will be equal to the width, the equivalent of the diameter of the circumference.
  final double indicatorHeight;

  /// Used to paint the top line
  final Paint topLinePaint;

  /// Used to paint the bottom line
  final Paint bottomLinePaint;

  /// Used to paint the indicator
  final Paint indicatorPaint;

  /// Whether it should paint a default indicator. It defaults to true.
  final bool paintIndicator;

  /// Whether this paint should start the line somewhere in the middle,
  /// according to [indicatorY]. It defaults to false.
  final bool isFirst;

  /// Whether this paint should end the line somewhere in the middle,
  /// according to [indicatorY]. It defaults to false.
  final bool isLast;

  /// If there must be a gap between the lines. The gap size will always be the
  /// [indicatorHeight] + [indicatorTopGap] + [indicatorBottomGap].
  final bool drawGap;

  /// The icon rendered with the default indicator.
  final IconData iconData;

  /// The icon color.
  final Color iconColor;

  /// The icon size. If not provided, the size will be adjusted according to [indicatorRadius].
  final double iconSize;

  @override
  void paint(Canvas canvas, Size size) {
    final hasGap = indicatorTopGap > 0 || indicatorBottomGap > 0 || drawGap;

    final centerWidth = size.width / 2;
    final indicatorTotalSize =
        indicatorHeight + indicatorBottomGap + indicatorTopGap;
    final position = calculateAxisPositioning(
      totalSize: size.height,
      objectSize: indicatorTotalSize,
      axisPosition: indicatorY,
    );

    if (!hasGap) {
      _drawSingleLine(canvas, centerWidth, position);
    } else {
      if (!isFirst) {
        _drawTopLine(canvas, centerWidth, position);
      }
      if (!isLast) {
        _drawBottomLine(canvas, centerWidth, position);
      }
    }

    if (paintIndicator) {
      final indicatorCenter = Offset(centerWidth, position.objectSpace.center);
      canvas.drawCircle(indicatorCenter, indicatorRadius, indicatorPaint);

      if (iconData != null) {
        var fontSize = iconSize;
        fontSize ??= (indicatorRadius * 2) - 10;

        final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
          fontFamily: iconData.fontFamily,
        ));
        builder.pushStyle(ui.TextStyle(
          fontSize: fontSize,
          color: iconColor,
        ));
        builder.addText(String.fromCharCode(iconData.codePoint));

        final paragraph = builder.build();
        paragraph.layout(const ui.ParagraphConstraints(width: 0.0));

        final halfIconSize = fontSize / 2;
        final offsetIcon = Offset(indicatorCenter.dx - halfIconSize,
            indicatorCenter.dy - halfIconSize);
        canvas.drawParagraph(paragraph, offsetIcon);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  void _drawSingleLine(
      Canvas canvas, double centerWidth, AxisPosition position) {
    if (!isFirst) {
      final beginTopLine = Offset(centerWidth, 0);
      final endTopLine = Offset(
        centerWidth,
        paintIndicator ? position.objectSpace.center : position.firstSpace.end,
      );
      canvas.drawLine(beginTopLine, endTopLine, topLinePaint);
    }

    if (!isLast) {
      final beginBottomLine = Offset(
        centerWidth,
        paintIndicator ? position.objectSpace.center : position.objectSpace.end,
      );
      final endBottomLine = Offset(centerWidth, position.secondSpace.end);
      canvas.drawLine(beginBottomLine, endBottomLine, bottomLinePaint);
    }
  }

  void _drawTopLine(
      Canvas canvas, double centerWidth, AxisPosition position) {
    final beginTopLine = Offset(centerWidth, 0);
    final endTopLine = Offset(centerWidth, position.firstSpace.end);

    final lineSize = endTopLine.dy;
    // if the line size is less or equal than 0, the line shouldn't be rendered
    if (lineSize > 0) {
      canvas.drawLine(beginTopLine, endTopLine, topLinePaint);
    }
  }

  void _drawBottomLine(
      Canvas canvas, double centerWidth, AxisPosition position) {
    final beginBottomLine = Offset(centerWidth, position.secondSpace.start);
    final endBottomLine = Offset(centerWidth, position.secondSpace.end);

    final lineSize = endBottomLine.dy - beginBottomLine.dy;
    // if the line size is less or equal than 0, the line shouldn't be rendered
    if (lineSize > 0) {
      canvas.drawLine(beginBottomLine, endBottomLine, bottomLinePaint);
    }
  }
}
