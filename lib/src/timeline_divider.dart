import 'package:flutter/material.dart';

import 'tile.dart';

/// This is a port from the original [Divider].
/// Except that this one allows defining the start and end
/// according to the width available, with percentage values
/// from 0.0 to 1.0
class TimelineDivider extends StatelessWidget {
  /// Creates a material design divider that can be used in conjunction to [TimelineTile].
  const TimelineDivider({
    Key? key,
    this.axis = TimelineAxis.horizontal,
    this.thickness = 2,
    this.begin = 0.0,
    this.end = 1.0,
    this.color = Colors.grey,
    this.isDotted = false,
    this.dotSpacing = 4.0,
    this.dotRadius = 2.0,
    this.isDashed = false,
    this.dashLength = 4.0,
    this.dashSpacing = 4.0,
  })  : assert(thickness >= 0.0, 'The thickness must be a positive value'),
        assert(begin >= 0.0 && begin <= 1.0,
            'The begin value must be between 0.0 and 1.0'),
        assert(end >= 0.0 && end <= 1.0,
            'The end value must be between 0.0 and 1.0'),
        assert(end > begin, 'The end value must be bigger than the begin'),
        super(key: key);

  /// The axis used to render the line at the [TimelineAxis.vertical]
  /// or [TimelineAxis.horizontal]. Usually, the opposite axis from the tiles.
  /// It defaults to [TimelineAxis.horizontal].
  final TimelineAxis axis;

  /// The thickness of the line drawn within the divider.
  ///
  /// It must be a positive value. It defaults to 2.
  final double thickness;

  /// Where the line must start to be drawn.
  /// This represents a percentage from the available width.
  ///
  /// It must be less than [end] and defaults to 0.0.
  final double begin;

  /// Where the drawn from the line must end.
  /// This represents a percentage from the available width.
  ///
  /// It must be bigger than [begin] and defaults to 1.0.
  final double end;

  /// The color to use when painting the line.
  ///
  /// It defaults to [Colors.grey].
  final Color color;

  /// Whether the line should be dotted.
  final bool isDotted;

  /// The spacing between dots.
  final double dotSpacing;

  /// The radius of each dot.
  final double dotRadius;

  /// Whether the line should be dashed.
  final bool isDashed;

  /// The length of each dash.
  final double dashLength;

  /// The spacing between dashes.
  final double dashSpacing;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TimelineDividerPainter(
        axis: axis,
        thickness: thickness,
        begin: begin,
        end: end,
        color: color,
        isDotted: isDotted,
        dotSpacing: dotSpacing,
        dotRadius: dotRadius,
        isDashed: isDashed,
        dashLength: dashLength,
        dashSpacing: dashSpacing,
      ),
      child: SizedBox(
        height: axis == TimelineAxis.horizontal ? thickness : double.infinity,
        width: axis == TimelineAxis.vertical ? thickness : double.infinity,
      ),
    );
  }
}

class _TimelineDividerPainter extends CustomPainter {
  _TimelineDividerPainter({
    required this.axis,
    required this.thickness,
    required this.begin,
    required this.end,
    required this.color,
    required this.isDotted,
    required this.dotSpacing,
    required this.dotRadius,
    required this.isDashed,
    required this.dashLength,
    required this.dashSpacing,
  });

  final TimelineAxis axis;
  final double thickness;
  final double begin;
  final double end;
  final Color color;
  final bool isDotted;
  final double dotSpacing;
  final double dotRadius;
  final bool isDashed;
  final double dashLength;
  final double dashSpacing;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness;

    final double halfThickness = thickness / 2;

    Offset start, finish;

    if (axis == TimelineAxis.horizontal) {
      final double width = size.width;
      start = Offset(width * begin, halfThickness);
      finish = Offset(width * end, halfThickness);
    } else {
      final double height = size.height;
      start = Offset(halfThickness, height * begin);
      finish = Offset(halfThickness, height * end);
    }

    if (isDotted) {
      _drawDottedLine(canvas, start, finish, paint, dotSpacing, dotRadius);
    } else if (isDashed) {
      _drawDashedLine(canvas, start, finish, paint, dashLength, dashSpacing);
    } else {
      canvas.drawLine(start, finish, paint);
    }
  }

  void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint,
      double spacing, double radius) {
    final double distance = (end - start).distance;
    final double dx = (end.dx - start.dx) / distance;
    final double dy = (end.dy - start.dy) / distance;

    for (double i = 0; i < distance; i += spacing) {
      final double px = start.dx + (dx * i);
      final double py = start.dy + (dy * i);
      canvas.drawCircle(Offset(px, py), radius, paint);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint,
      double dashLength, double dashSpacing) {
    final double distance = (end - start).distance;
    final double dx = (end.dx - start.dx) / distance;
    final double dy = (end.dy - start.dy) / distance;

    final double dashPatternLength = dashLength + dashSpacing;

    for (double i = 0; i < distance; i += dashPatternLength) {
      double currentDashEnd = i + dashLength;

      if (currentDashEnd > distance) {
        currentDashEnd = distance;
      }

      final double px1 = start.dx + (dx * i);
      final double py1 = start.dy + (dy * i);
      final double px2 = start.dx + (dx * currentDashEnd);
      final double py2 = start.dy + (dy * currentDashEnd);

      canvas.drawLine(Offset(px1, py1), Offset(px2, py2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
