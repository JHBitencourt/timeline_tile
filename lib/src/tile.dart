import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:timeline_tile/src/axis.dart';
import 'package:timeline_tile/src/style.dart';

/// The axis used on the [TimelineTile].
enum TimelineAxis {
  /// Renders the tile in the [vertical] axis.
  vertical,

  /// Renders the tile in the [horizontal] axis.
  horizontal,
}

/// The alignment used on the [TimelineTile].
enum TimelineAlign {
  /// Automatically align the line to the start according to [TimelineAxis],
  /// only the ([TimelineTile.rightChild]) will be available.
  start,

  /// Automatically align the line to the end according to [TimelineAxis],
  /// only the ([TimelineTile.leftChild]) will be available.
  end,

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
    Key? key,
    this.axis = TimelineAxis.vertical,
    this.alignment = TimelineAlign.start,
    this.startChild,
    this.endChild,
    this.lineXY,
    this.hasIndicator = true,
    this.isFirst = false,
    this.isLast = false,
    this.isDotted = false,
    this.dashWidth = 9.0,
    this.dashSpace = 5.0,
    this.indicatorStyle = const IndicatorStyle(width: 25),
    this.beforeLineStyle = const LineStyle(),
    LineStyle? afterLineStyle,
  })  : afterLineStyle = afterLineStyle ?? beforeLineStyle,
        assert(alignment != TimelineAlign.start || startChild == null,
            'Cannot provide startChild with automatic alignment to the left'),
        assert(alignment != TimelineAlign.end || endChild == null,
            'Cannot provide endChild with automatic alignment to the right'),
        assert(
            alignment != TimelineAlign.manual ||
                (lineXY != null && lineXY >= 0.0 && lineXY <= 1.0),
            'The lineX must be provided when aligning manually, '
            'and must be a value between 0.0 and 1.0 inclusive'),
        super(key: key);

  /// The axis used on the tile. See [TimelineAxis].
  /// It defaults to [TimelineAxis.vertical]
  final TimelineAxis axis;

  ///True if the line is dotted.
  ///It defaults to false
  final bool isDotted;

  ///Sets the width of the dashed line. Defaults to 9.
  final double dashWidth;

  ///Sets the space between the dashed lines. Defaults to 5
  final double dashSpace;

  /// The alignment used on the line. See [TimelineAlign].
  /// It defaults to [TimelineAlign.start]
  final TimelineAlign alignment;

  /// The child widget positioned at the start
  final Widget? startChild;

  /// The child widget positioned at the end
  final Widget? endChild;

  /// The X (in case of [TimelineAxis.vertical]) or Y (in case of [TimelineAxis.horizontal])
  /// axis value used to position the line when [TimelineAlign.manual].
  /// Must be a value from 0.0 to 1.0
  final double? lineXY;

  /// Whether it should have an indicator (default or custom).
  /// It defaults to true.
  final bool hasIndicator;

  /// Whether this is the first tile from the timeline.
  /// In this case, it won't be rendered a line before the indicator.
  final bool isFirst;

  /// Whether this is the last tile from the timeline.
  /// In this case, it won't be rendered a line after the indicator.
  final bool isLast;

  /// The style used to customize the indicator.
  final IndicatorStyle indicatorStyle;

  /// The style used to customize the line rendered before the indicator.
  final LineStyle beforeLineStyle;

  /// The style used to customize the line rendered after the indicator.
  /// If null, it defaults to [beforeLineStyle].
  final LineStyle afterLineStyle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double startCrossAxisSpace = 0;
        double endCrossAxisSpace = 0;
        if (axis == TimelineAxis.vertical) {
          startCrossAxisSpace = indicatorStyle.padding.left;
          endCrossAxisSpace = indicatorStyle.padding.right;
        } else {
          startCrossAxisSpace = indicatorStyle.padding.top;
          endCrossAxisSpace = indicatorStyle.padding.bottom;
        }

        final children = <Widget>[
          if (startCrossAxisSpace > 0)
            SizedBox(
              height:
                  axis == TimelineAxis.vertical ? null : startCrossAxisSpace,
              width: axis == TimelineAxis.vertical ? startCrossAxisSpace : null,
            ),
          _Indicator(
            axis: axis,
            isDotted: isDotted,
            beforeLineStyle: beforeLineStyle,
            afterLineStyle: afterLineStyle,
            indicatorStyle: indicatorStyle,
            hasIndicator: hasIndicator,
            isLast: isLast,
            isFirst: isFirst,
            dashSpace: dashSpace,
            dashWidth: dashWidth,
          ),
          if (endCrossAxisSpace > 0)
            SizedBox(
              height: axis == TimelineAxis.vertical ? null : endCrossAxisSpace,
              width: axis == TimelineAxis.vertical ? endCrossAxisSpace : null,
            ),
        ];

        final defaultChild = axis == TimelineAxis.vertical
            ? Container(height: 100)
            : Container(width: 100);
        if (alignment == TimelineAlign.start) {
          children.add(Expanded(child: endChild ?? defaultChild));
        } else if (alignment == TimelineAlign.end) {
          children.insert(0, Expanded(child: startChild ?? defaultChild));
        } else {
          final indicatorAxisXY =
              alignment == TimelineAlign.center ? 0.5 : lineXY!;
          final indicatorTotalSize = _indicatorTotalSize();

          final positioning = calculateAxisPositioning(
            totalSize: axis == TimelineAxis.vertical
                ? constraints.maxWidth
                : constraints.maxHeight,
            objectSize: indicatorTotalSize,
            axisPosition: indicatorAxisXY,
          );

          if (positioning.firstSpace.size > 0) {
            children.insert(
              0,
              SizedBox(
                height: axis == TimelineAxis.horizontal
                    ? positioning.firstSpace.size
                    : null,
                width: axis == TimelineAxis.vertical
                    ? positioning.firstSpace.size
                    : null,
                child: startChild ?? defaultChild,
              ),
            );
          }

          if (positioning.secondSpace.size > 0) {
            children.add(
              SizedBox(
                height: axis == TimelineAxis.horizontal
                    ? positioning.secondSpace.size
                    : null,
                width: axis == TimelineAxis.vertical
                    ? positioning.secondSpace.size
                    : null,
                child: endChild ?? defaultChild,
              ),
            );
          }
        }

        return axis == TimelineAxis.vertical
            ? IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: children,
                ),
              )
            : IntrinsicWidth(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: children,
                ),
              );
      },
    );
  }

  double _indicatorTotalSize() {
    if (axis == TimelineAxis.vertical) {
      return indicatorStyle.padding.left +
          indicatorStyle.padding.right +
          (hasIndicator
              ? indicatorStyle.width
              : max(beforeLineStyle.thickness, afterLineStyle.thickness));
    }

    return indicatorStyle.padding.top +
        indicatorStyle.padding.bottom +
        (hasIndicator
            ? indicatorStyle.height
            : max(beforeLineStyle.thickness, afterLineStyle.thickness));
  }
}

class _Indicator extends StatelessWidget {
  const _Indicator({
    required this.axis,
    required this.beforeLineStyle,
    required this.afterLineStyle,
    required this.indicatorStyle,
    required this.hasIndicator,
    required this.isFirst,
    required this.isLast,
    required this.isDotted,
    required this.dashSpace,
    required this.dashWidth,
  });

  /// See [TimelineTile.axis]
  final TimelineAxis axis;

  final bool isDotted;

  final double dashWidth;

  final double dashSpace;

  /// See [TimelineTile.beforeLineStyle]
  final LineStyle beforeLineStyle;

  /// See [TimelineTile.afterLineStyle]
  final LineStyle afterLineStyle;

  /// See [TimelineTile.indicatorStyle]
  final IndicatorStyle indicatorStyle;

  /// See [TimelineTile.hasIndicator]
  final bool hasIndicator;

  /// See [TimelineTile.isFirst]
  final bool isFirst;

  /// See [TimelineTile.isLast]
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    double size;
    if (axis == TimelineAxis.vertical) {
      size = hasIndicator
          ? indicatorStyle.width
          : max(beforeLineStyle.thickness, afterLineStyle.thickness);
    } else {
      size = hasIndicator
          ? indicatorStyle.height
          : max(beforeLineStyle.thickness, afterLineStyle.thickness);
    }

    final childrenStack = <Widget>[
      SizedBox(
        height: axis == TimelineAxis.vertical ? double.infinity : size,
        width: axis == TimelineAxis.vertical ? size : double.infinity,
      )
    ];

    final renderDefaultIndicator =
        hasIndicator && indicatorStyle.indicator == null;
    if (!renderDefaultIndicator) {
      childrenStack.add(
        _buildCustomIndicator(),
      );
    }

    final painter = _TimelinePainter(
      axis: axis,
      beforeLineStyle: beforeLineStyle,
      afterLineStyle: afterLineStyle,
      indicatorStyle: indicatorStyle,
      paintIndicator: renderDefaultIndicator,
      isFirst: isFirst,
      isLast: isLast,
      isDotted: isDotted,
      dashSpace: dashSpace,
      dashWidth: dashWidth,
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
          AxisPosition position;
          EdgeInsets spaceChildren;
          EdgeInsets spacePadding;
          if (axis == TimelineAxis.vertical) {
            position = calculateAxisPositioning(
              totalSize: constraints.maxHeight,
              objectSize: indicatorStyle.totalHeight,
              axisPosition: indicatorStyle.indicatorXY,
            );
            spaceChildren = EdgeInsets.only(
              top: position.firstSpace.size,
              bottom: position.secondSpace.size,
            );
            spacePadding = EdgeInsets.only(
              top: indicatorStyle.padding.top,
              bottom: indicatorStyle.padding.bottom,
            );
          } else {
            position = calculateAxisPositioning(
              totalSize: constraints.maxWidth,
              objectSize: indicatorStyle.totalWidth,
              axisPosition: indicatorStyle.indicatorXY,
            );
            spaceChildren = EdgeInsets.only(
              left: position.firstSpace.size,
              right: position.secondSpace.size,
            );
            spacePadding = EdgeInsets.only(
              left: indicatorStyle.padding.left,
              right: indicatorStyle.padding.right,
            );
          }

          return Padding(
            padding: spaceChildren,
            child: Padding(
              padding: spacePadding,
              child: SizedBox(
                height: indicatorStyle.height,
                width: indicatorStyle.width,
                child: indicatorStyle.indicator,
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
    required this.axis,
    this.paintIndicator = true,
    this.isFirst = false,
    this.isLast = false,
    required this.isDotted,
    required this.dashWidth,
    required this.dashSpace,
    required IndicatorStyle indicatorStyle,
    required LineStyle beforeLineStyle,
    required LineStyle afterLineStyle,
  })   : beforeLinePaint = Paint()
          ..color = beforeLineStyle.color
          // ..color = Colors.red
          ..strokeWidth = beforeLineStyle.thickness,
        afterLinePaint = Paint()
          ..color = afterLineStyle.color
          // ..color = Colors.blue
          ..strokeWidth = afterLineStyle.thickness,
        indicatorPaint =
            !paintIndicator ? null : (Paint()..color = indicatorStyle.color),
        indicatorXY = indicatorStyle.indicatorXY,
        indicatorSize = axis == TimelineAxis.vertical
            ? (paintIndicator
                ? indicatorStyle.width
                : (indicatorStyle.indicator != null
                    ? indicatorStyle.height
                    : 0))
            : (paintIndicator
                ? indicatorStyle.height
                : (indicatorStyle.indicator != null
                    ? indicatorStyle.width
                    : 0)),
        indicatorStartGap = axis == TimelineAxis.vertical
            ? indicatorStyle.padding.top
            : indicatorStyle.padding.left,
        indicatorEndGap = axis == TimelineAxis.vertical
            ? indicatorStyle.padding.bottom
            : indicatorStyle.padding.right,
        drawGap = indicatorStyle.drawGap,
        iconData = indicatorStyle.iconStyle != null
            ? indicatorStyle.iconStyle?.iconData
            : null,
        iconColor = indicatorStyle.iconStyle != null
            ? indicatorStyle.iconStyle?.color
            : null,
        iconSize = indicatorStyle.iconStyle != null
            ? indicatorStyle.iconStyle?.fontSize
            : null;
  /// The axis used to render the line at the [TimelineAxis.vertical]
  /// or [TimelineAxis.horizontal].
  final TimelineAxis axis;

  final bool isDotted;
  final double dashWidth, dashSpace;

  /// Value from 0.0 to 1.0 indicating the percentage in which the indicator
  /// should be positioned on the line, either on Y if [TimelineAxis.vertical]
  /// or X if [TimelineAxis.horizontal].
  /// For example, 0.2 means 20% from start to end. It defaults to 0.5.
  final double indicatorXY;

  /// A gap/space between the line and the indicator
  final double indicatorStartGap;

  /// A gap/space between the line and the indicator
  final double indicatorEndGap;

  /// The size from the indicator. If it is the default indicator, the height
  /// will be equal to the width (when axis vertical), or the width will be
  /// equal to the height (when axis horizontal), which is the equivalent of the
  /// diameter of the circumference.
  final double indicatorSize;

  /// Used to paint the top line
  final Paint beforeLinePaint;

  /// Used to paint the bottom line
  final Paint afterLinePaint;

  /// Used to paint the indicator
  final Paint? indicatorPaint;

  /// Whether it should paint a default indicator. It defaults to true.
  final bool paintIndicator;

  /// Whether this paint should start the line somewhere in the middle,
  /// according to [indicatorY]. It defaults to false.
  final bool isFirst;

  /// Whether this paint should end the line somewhere in the middle,
  /// according to [indicatorY]. It defaults to false.
  final bool isLast;

  /// If there must be a gap between the lines. The gap size will always be the
  /// [indicatorSize] + [indicatorStartGap] + [indicatorEndGap].
  final bool drawGap;

  /// The icon rendered with the default indicator.
  final IconData? iconData;

  /// The icon color.
  final Color? iconColor;

  /// The icon size. If not provided, the size will be adjusted according to [indicatorRadius].
  final double? iconSize;

  @override
  void paint(Canvas canvas, Size size) {
    final hasGap = indicatorStartGap > 0 || indicatorEndGap > 0 || drawGap;

    final centerAxis =
        axis == TimelineAxis.vertical ? size.width / 2 : size.height / 2;
    final indicatorTotalSize =
        indicatorSize + indicatorEndGap + indicatorStartGap;
    final position = calculateAxisPositioning(
      totalSize: axis == TimelineAxis.vertical ? size.height : size.width,
      objectSize: indicatorTotalSize,
      axisPosition: indicatorXY,
    );

    if (!hasGap) {
      _drawSingleLine(canvas, centerAxis, position);
    } else {
      if (!isFirst) {
        _drawBeforeLine(canvas, centerAxis, position);
      }
      if (!isLast) {
        _drawAfterLine(canvas, centerAxis, position);
      }
    }

    if (paintIndicator) {
      final indicatorRadius =
          (position.objectSpace.size - indicatorStartGap - indicatorEndGap) / 2;
      final indicatorCenterPoint =
          position.objectSpace.start + indicatorStartGap + indicatorRadius;

      final indicatorCenter = axis == TimelineAxis.vertical
          ? Offset(centerAxis, indicatorCenterPoint)
          : Offset(indicatorCenterPoint, centerAxis);
      canvas.drawCircle(indicatorCenter, indicatorRadius, indicatorPaint!);

      if (iconData != null) {
        var fontSize = iconSize;
        fontSize ??= (indicatorRadius * 2) - 10;

        final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
          fontFamily: iconData!.fontFamily,
        ));
        builder.pushStyle(ui.TextStyle(
          fontSize: fontSize,
          color: iconColor,
        ));
        builder.addText(String.fromCharCode(iconData!.codePoint));

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
      Canvas canvas, double centerAxis, AxisPosition position) {
    if (!isFirst) {
      final beginTopLine = axis == TimelineAxis.vertical
          ? Offset(centerAxis, 0)
          : Offset(0, centerAxis);
      final endTopLine = axis == TimelineAxis.vertical
          ? Offset(
              centerAxis,
              paintIndicator || !drawGap
                  ? position.objectSpace.center
                  : position.firstSpace.end,
            )
          : Offset(
              paintIndicator || !drawGap
                  ? position.objectSpace.center
                  : position.firstSpace.end,
              centerAxis,
            );

      if (isDotted) {
        if ( axis == TimelineAxis.vertical ) {
          double startY = 0;
          while (startY <= endTopLine.dy - dashSpace / 2) {
            canvas.drawLine(Offset(centerAxis, startY),
                Offset(centerAxis, startY + dashWidth), beforeLinePaint);
            startY += dashWidth + dashSpace;
          }
        } else {
          double startX = 0;
          while (startX <= endTopLine.dx - dashSpace / 2) {
            canvas.drawLine(Offset(startX, centerAxis),
                Offset(startX + dashWidth, centerAxis), beforeLinePaint);
            startX += dashWidth + dashSpace;
          }
        }
      } else {
        canvas.drawLine(beginTopLine, endTopLine, beforeLinePaint);
      }
    }

    if (!isLast) {
      final beginBottomLine = axis == TimelineAxis.vertical
          ? Offset(
              centerAxis,
              paintIndicator || !drawGap
                  ? position.objectSpace.center
                  : position.objectSpace.end,
            )
          : Offset(
              paintIndicator || !drawGap
                  ? position.objectSpace.center
                  : position.objectSpace.end,
              centerAxis,
            );
      final endBottomLine = axis == TimelineAxis.vertical
          ? Offset(centerAxis, position.secondSpace.end)
          : Offset(position.secondSpace.end, centerAxis);

      if(isDotted == true) {
        if(axis == TimelineAxis.vertical) {
          double startY = beginBottomLine.dy;

          while (startY <= endBottomLine.dy - (dashWidth + dashSpace)) {
            canvas.drawLine(Offset(centerAxis, startY), Offset(centerAxis, startY+dashWidth), afterLinePaint);
            startY += dashWidth + dashSpace;
          }
        } else {
          double startX = beginBottomLine.dx;
          while (startX <= beginBottomLine.dx - (dashWidth + dashSpace)) {
            canvas.drawLine(Offset(startX, centerAxis), Offset(startX+dashWidth, centerAxis), afterLinePaint);
            startX += dashWidth + dashSpace;
          }
        }
      } else {
        canvas.drawLine(beginBottomLine, endBottomLine, afterLinePaint);
      }
    }
  }

  void _drawBeforeLine(
      Canvas canvas, double centerAxis, AxisPosition position) {
    final beginTopLine = axis == TimelineAxis.vertical
        ? Offset(centerAxis, 0)
        : Offset(0, centerAxis);
    final endTopLine = axis == TimelineAxis.vertical
        ? Offset(centerAxis, position.firstSpace.end)
        : Offset(position.firstSpace.end, centerAxis);

    final lineSize =
        axis == TimelineAxis.vertical ? endTopLine.dy : endTopLine.dx;
    // if the line size is less or equal than 0, the line shouldn't be rendered
    if (lineSize>0) {
      if (isDotted) {
        if(axis == TimelineAxis.vertical) {
          double startY = 0;
          while (startY <= endTopLine.dy-dashSpace/2) {
            canvas.drawLine(Offset(centerAxis, startY), Offset(centerAxis, startY+dashWidth), beforeLinePaint);
            startY += dashWidth + dashSpace;
          }
        } else {
          double startX = 0;
          while (startX <= endTopLine.dx-dashSpace/2) {
            canvas.drawLine(Offset(startX, centerAxis), Offset(startX+dashWidth ,centerAxis), beforeLinePaint);
            startX += dashWidth + dashSpace;
          }
        }
      } else {
        canvas.drawLine(beginTopLine, endTopLine, beforeLinePaint);
      }
    }
  }

  void _drawAfterLine(Canvas canvas, double centerAxis, AxisPosition position) {


    final beginBottomLine = axis == TimelineAxis.vertical
        ? Offset(centerAxis, position.secondSpace.start)
        : Offset(position.secondSpace.start, centerAxis);
    final endBottomLine = axis == TimelineAxis.vertical
        ? Offset(centerAxis, position.secondSpace.end)
        : Offset(position.secondSpace.end, centerAxis);

    final lineSize = axis == TimelineAxis.vertical
        ? endBottomLine.dy - beginBottomLine.dy
        : endBottomLine.dx - beginBottomLine.dx;
    // if the line size is less or equal than 0, the line shouldn't be rendered
    if (lineSize>0) {
      if(isDotted == true) {
        if(axis == TimelineAxis.vertical) {
          double startY = beginBottomLine.dy;

          while (startY <= endBottomLine.dy - (dashWidth + dashSpace)) {
            canvas.drawLine(Offset(centerAxis, startY), Offset(centerAxis, startY+dashWidth), afterLinePaint);
            startY += dashWidth + dashSpace;
          }
        } else {
          double startX = beginBottomLine.dx;
          while (startX <= beginBottomLine.dx - (dashWidth + dashSpace)) {
            canvas.drawLine(Offset(startX, centerAxis), Offset(startX+dashWidth, centerAxis), afterLinePaint);
            startX += dashWidth + dashSpace;
          }
        }
      } else {
        canvas.drawLine(beginBottomLine, endBottomLine, afterLinePaint);
      }
    }
  }
}

